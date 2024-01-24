import 'dart:async';
import 'package:client/controller/bottom_bar/filter_controller.dart';
import 'package:client/controller/map_list/map_list_controller.dart';
import 'package:client/controller/propertise/properties_controller.dart';
import 'package:client/controller/static_api/static_controller.dart';
import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/model/property.dart';
import 'package:client/view/home_information/home_information.dart';
import 'package:client/view/search/closest_properties.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:geolocator/geolocator.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  MapListController mapListController = Get.put(MapListController());
  FilterController filterController = Get.put(FilterController());
  LoginControllerImp loginController = Get.put(LoginControllerImp());
  ManagePropertiesController propertiesController =
      Get.put(ManagePropertiesController());
  GoogleMapController? mapController;

  bool userNotified = false;
  String snackBarMessage = "You are too far out, please zoom in";
  String locality = "";
  late Timer _timer;

  bool mapButtonSelected = false;

  bool drawButtonSelected = false;
  MapType currentMapType = MapType.normal;
  late BitmapDescriptor icon;

  @override
  bool get wantKeepAlive => true; // Keep the state alive

  @override
  void initState() {
    super.initState();
    loadIcon();
    _timer = Timer(const Duration(seconds: 1), () {});
    WidgetsBinding.instance.addObserver(this);
    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(mapListController.currentPosition.target, 15),
    );
    print(mapListController.currentPosition.target);
    setState(() {});
  }

  Future<void> loadIcon() async {
    icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/flag.png",
    );
  }

  void loadData() async {
    mapListController.currentPosition =
        await mapListController.getCurrentPosition();
    mapListController.isLoading = true;
    _timer = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          mapListController.isLoading = false;
        });
      }
    });
  }

  Future<void> whenCameraMove(CameraPosition position) async {
    filterController.currentPosition = position;
    print(
        "============================================================ whenCameraMove");
    if (mapController == null) {
      return;
    }

    final LatLngBounds? bounds = await mapController!.getVisibleRegion();
    if (bounds == null) {
      return;
    }

    if (mapListController.newZoom < 10) {
      if (!userNotified) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(snackBarMessage),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 2),
        ));
        userNotified = true;
      }
    } else {
      userNotified = false;
    }

    LatLng centerCoordinates = position.target;

    mapListController.currentPosition = CameraPosition(
      target: position.target,
      zoom: mapListController.newZoom,
    );
    // if (mounted) {
    //   setState(() {
        // mapListController.visibleMarkers.clear();
        // mapListController.visibleProperties.clear();

    // mapListController.visibleMarkers.clear();
    // mapListController.visibleProperties.clear();

    if (mapListController.newZoom >= 10) {
      mapListController.visibleProperties = filterController
          .listProperty.listDto
          .where((property) =>
              property.location!.latitude >= bounds.southwest.latitude &&
              property.location!.latitude <= bounds.northeast.latitude &&
              property.location!.longitude >= bounds.southwest.longitude &&
              property.location!.longitude <= bounds.northeast.longitude)
          .toList();

      mapListController.visibleMarkers = filterController.listProperty.listDto
          .map((property) => Marker(
                markerId: MarkerId(property.id.toString()),
                position: LatLng(
                  property.location?.latitude ?? 0.0,
                  property.location?.longitude ?? 0.0,
                ),
                icon: property.userId == loginController.userDto?["id"]
                    ? icon
                    : filterController.listingType
                        ? BitmapDescriptor.defaultMarker
                        : BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueBlue),
                onTap: () {
                  _showMarkerInfo(property);
                },
              ))
          .toSet();

      reciveGeocode(centerCoordinates);
    }
    
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> reciveGeocode(LatLng coordinates) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        coordinates.latitude,
        coordinates.longitude,
      );
      if (placemarks.isNotEmpty) {
        locality = placemarks[0].locality!;
        if (locality != mapListController.currentLocationName.value &&
            locality != "") {
          mapListController.currentLocationName.value = locality;
          filterController.getProperties();

          print(
              "=============================== Area in ${mapListController.currentLocationName.value}");
        }
      }
    } catch (e) {}
  }

  void changeMapType() {
    setState(() {
      currentMapType =
          currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
      mapButtonSelected = currentMapType == MapType.satellite;
    });
  }

  void toggleLocationButton() {
    setState(() {
      mapListController.locationButtonSelected =
          !mapListController.locationButtonSelected;
    });

    Timer(const Duration(seconds: 20), () {
      if (mounted) {
        setState(() {
          mapListController.locationButtonSelected =
              !mapListController.locationButtonSelected;
        });
      }
    });
  }

  void toggleDrawButton() {
    setState(() {
      drawButtonSelected = !drawButtonSelected;
    });
  }

  void _showMarkerInfo(Property property) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              height: MediaQuery.of(context).size.height / 2.2,
              width: 500,
              child: InkWell(
                onTap: () {
                  Get.off(() => HomeInformation(property: property));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (property.propertyFiles != null &&
                        property.propertyFiles!.isNotEmpty)
                      HomeImageWidget(
                        property: property,
                      ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 25, top: 15, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 196, 39, 27),
                                ),
                              ),
                              Text(
                                " ${property.listingType}",
                                style: const TextStyle(fontSize: 17.5),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "\$${NumberFormat.decimalPattern().format(property.price)} ${property.listingType == "For monthly rent" ? "/ monthly" : property.listingType == "For daily rent" ? "/ daily" : ""}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${property.numberOfBedRooms} ',
                                  style: const TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 196, 39, 27),
                                  ),
                                ),
                                const TextSpan(
                                  text: 'bedrooms, ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: '${property.numberOfBathRooms} ',
                                  style: const TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 196, 39, 27),
                                  ),
                                ),
                                const TextSpan(
                                  text: 'bathrooms, ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: '${property.squareMetersArea} ',
                                  style: const TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 196, 39, 27),
                                  ),
                                ),
                                const TextSpan(
                                  text: 'meters',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "${property.location!.city}, ${property.location!.country}",
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            property.propertyDescription,
                            style: const TextStyle(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    mapListController.mapContext = context;

    return VisibilityDetector(
      key: const Key('Map'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (mapListController.isLoading) {
          if (mounted) {
            setState(() {});
          }
          loadData();
          // whenCameraMove();
        }
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: mapListController.locationButtonSelected
            ? SizedBox(
                height: 40,
                child: FloatingActionButton.extended(
                  heroTag: "btn1",
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  onPressed: () async {
                    Get.to(() => const ClosestProperties());
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: const Text("Give my closest properties"),
                ),
              )
            : null,

        // Body
        body: Stack(
          children: [
            Visibility(
              visible:
                  mapListController.isLoading || filterController.isLoading,
              child: const LinearProgressIndicator(
                  backgroundColor: Colors.black,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 2),
            ),
            Visibility(
              visible:
                  !mapListController.isLoading || filterController.isLoading,
              child: GoogleMap(
                zoomControlsEnabled: true,
                mapType: currentMapType,
                initialCameraPosition: mapListController.currentPosition,
                onMapCreated: (controller) {
                  mapController = controller;

                  mapController?.animateCamera(
                    CameraUpdate.newLatLngZoom(
                      mapListController.currentPosition.target,
                      13,
                    ),
                  );
                },
                myLocationButtonEnabled: true,
                markers: mapListController.visibleMarkers,
                onCameraMove: (CameraPosition position) {
                  setState(() {
                    mapListController.newZoom = position.zoom;
                    whenCameraMove(position);
                  });
                },
              ),
            ),
            Visibility(
              visible: !mapListController.isLoading,
              child: Container(
                padding: const EdgeInsets.only(top: 15, right: 8),
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    Material(
                      elevation: 4,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: changeMapType,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                mapButtonSelected ? Colors.black : Colors.white,
                          ),
                          child: Icon(Icons.map,
                              size: 25,
                              color: mapButtonSelected
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Material(
                      elevation: 4,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () async {
                          if (!mapListController.locationButtonSelected) {
                            bool isLocationEnabled =
                                await Geolocator.isLocationServiceEnabled();

                            if (!isLocationEnabled) {
                              isLocationEnabled =
                                  await Geolocator.openLocationSettings();
                            }

                            setState(() {
                              toggleLocationButton();
                            });

                            CameraPosition currentPosition =
                                await mapListController.getCurrentPosition();

                            mapController!.animateCamera(
                              CameraUpdate.newLatLngZoom(
                                currentPosition.target,
                                15.0,
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mapListController.locationButtonSelected
                                ? Colors.black
                                : Colors.white,
                          ),
                          child: Icon(
                            Icons.my_location,
                            size: 25,
                            color: mapListController.locationButtonSelected
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Material(
                      elevation: 4,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: toggleDrawButton,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: drawButtonSelected
                                ? Colors.black
                                : Colors.white,
                          ),
                          child: Icon(Icons.layers,
                              size: 25,
                              color: drawButtonSelected
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    mapController?.dispose();
    _timer.cancel();
    super.dispose();
  }
}

// HomeImageWidget
// HomeImageWidget

class HomeImageWidget extends StatefulWidget {
  final Property property;

  HomeImageWidget({
    required this.property,
  });

  @override
  _MarkerInfoWidgetState createState() => _MarkerInfoWidgetState();
}

class _MarkerInfoWidgetState extends State<HomeImageWidget> {
  late bool isFavorite;
  StaticController staticController = Get.put(StaticController());

  @override
  void initState() {
    // Check if property with the same ID exists in favoriteProperties
    isFavorite = staticController.favoriteProperties
        .any((favProperty) => favProperty.id == widget.property.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Image
    if (widget.property.propertyFiles != null &&
        widget.property.propertyFiles!.isNotEmpty) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            child: Image.network(
              widget.property.propertyFiles![0].downloadUrls!,
              width: double.infinity,
              height: 190,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Shimmer.fromColors(
                    baseColor: Colors.black12,
                    highlightColor: Colors.black26,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(30)),
                      child: Container(
                        width: double.infinity,
                        height: 190,
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              },
            ),
          ),

          // To add the house to favorites
          Positioned(
            bottom: 16,
            right: 16,
            child: InkWell(
              onTap: () async {
                setState(() {});
                ScaffoldMessenger.of(context).clearSnackBars();
                SnackBar snackBar;

                // If it is in favourites
                if (isFavorite) {
                  setState(() {
                    isFavorite = false;
                  });
                  // Remove property with the same ID from favoriteProperties
                  staticController.favoriteProperties.removeWhere(
                      (favProperty) => favProperty.id == widget.property.id);
                  snackBar = const SnackBar(
                    content: Text("Removed Successfully"),
                    backgroundColor: Colors.red,
                  );
                } else {
                  // If it is not in favourites
                  setState(() {
                    isFavorite = true;
                  });
                  staticController.favoriteProperties.add(widget.property);
                  snackBar = const SnackBar(
                    content: Text("Added Successfully"),
                    backgroundColor: Colors.blue,
                  );
                }

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(149, 224, 224, 224),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: const Color.fromARGB(255, 196, 39, 27),
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
