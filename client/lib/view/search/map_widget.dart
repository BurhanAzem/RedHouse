import 'dart:async';
import 'package:client/controller/bottom_bar/filter_controller.dart';
import 'package:client/controller/map_list/map_list_controller.dart';
import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/model/property.dart';
import 'package:client/view/home_information/home_information.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluster/fluster.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget>
    with AutomaticKeepAliveClientMixin {
  MapListController mapListController = Get.put(MapListController());
  FilterController filterControllerr = Get.put(FilterController());
  GoogleMapController? mapController;

  bool userNotified = false;
  String snackBarMessage = "You are too far out, please zoom in";
  String locality = "";
  late Timer _timer;

  bool mapButtonSelected = false;
  bool locationButtonSelected = false;
  bool drawButtonSelected = false;
  MapType currentMapType = MapType.normal;

  @override
  bool get wantKeepAlive => true; // Keep the state alive

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    filterControllerr.getProperties();

    mapListController.isLoading = true;
    _timer = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          mapListController.isLoading = false;
        });
      }
    });
  }

  Future<void> whenCameraMove() async {
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

    final LatLng centerCoordinates = LatLng(
      (bounds.southwest.latitude + bounds.northeast.latitude) / 2,
      (bounds.southwest.longitude + bounds.northeast.longitude) / 2,
    );

    mapListController.currentPosition = CameraPosition(
      target: centerCoordinates,
      zoom: mapListController.newZoom,
    );

    setState(() {
      mapListController.visibleMarkers.clear();
      mapListController.visibleProperties.clear();

      if (mapListController.newZoom >= 10) {
        mapListController.visibleProperties = filterControllerr
            .listProperty.listDto
            .where((property) =>
                property.location!.latitude >= bounds.southwest.latitude &&
                property.location!.latitude <= bounds.northeast.latitude &&
                property.location!.longitude >= bounds.southwest.longitude &&
                property.location!.longitude <= bounds.northeast.longitude)
            .toSet();

        mapListController.allMarkers = filterControllerr
            .getMarkerLocations(filterControllerr.listProperty.listDto);

        mapListController.visibleMarkers = mapListController.allMarkers
            .map((marker) => marker.toMarker())
            .toSet();

        reverseGeocode(centerCoordinates);
      }
    });
  }

  Future<void> reverseGeocode(LatLng coordinates) async {
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
          print("Area in ${mapListController.currentLocationName.value}");
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
      locationButtonSelected = !locationButtonSelected;
    });
    Timer(const Duration(seconds: 1), () {
      setState(() {
        locationButtonSelected = !locationButtonSelected;
      });
    });
  }

  void toggleDrawButton() {
    setState(() {
      drawButtonSelected = !drawButtonSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    mapListController.mapContext = context;

    return VisibilityDetector(
      key: const Key('Map'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (mapListController.isLoading) {
          setState(() {});
          loadData();
          whenCameraMove();
        }
      },
      child: Stack(
        children: [
          Visibility(
            visible: mapListController.isLoading,
            child: const LinearProgressIndicator(
                backgroundColor: Colors.black,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 2),
          ),
          Visibility(
            visible: !mapListController.isLoading,
            child: GoogleMap(
              zoomControlsEnabled: true,
              mapType: currentMapType,
              initialCameraPosition: mapListController.currentPosition,
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              markers: mapListController.visibleMarkers,
              onCameraMove: (CameraPosition position) {
                mapListController.newZoom = position.zoom;
                whenCameraMove();
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
                      onTap: toggleLocationButton,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: locationButtonSelected
                              ? Colors.black
                              : Colors.white,
                        ),
                        child: Icon(Icons.my_location,
                            size: 25,
                            color: locationButtonSelected
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
                      onTap: toggleDrawButton,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              drawButtonSelected ? Colors.black : Colors.white,
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
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class MapMarker extends Clusterable {
  MapListController controller = Get.put(MapListController());
  FilterController filterController = Get.put(FilterController());
  LoginControllerImp loginController = Get.put(LoginControllerImp());

  Property property;
  final LatLng position;

  MapMarker({
    required this.property,
    required this.position,
  });

  get context => null;

  Marker toMarker() => Marker(
        markerId: MarkerId(property.id.toString()),
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
        icon: property.userId == loginController.userDto?["id"]
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet)
            : filterController.listingType
                ? BitmapDescriptor.defaultMarker
                : BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
        onTap: () {
          _showMarkerInfo(property);
        },
      );

  void _showMarkerInfo(Property property) {
    String homePrice() {
      String price =
          "\$${NumberFormat.decimalPattern().format(property.price)}";
      if (property.listingType == "For monthly rent") {
        price += "/monthly";
      } else if (property.listingType == "For daily rent") {
        price += "/daily";
      }
      return price;
    }

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      context: controller.mapContext ?? context,
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
                        homeImageWidget(
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
                              homePrice(),
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
                ));
          },
        );
      },
    );
  }
}

class homeImageWidget extends StatefulWidget {
  final Property property;

  homeImageWidget({
    required this.property,
  });

  @override
  _MarkerInfoWidgetState createState() => _MarkerInfoWidgetState();
}

class _MarkerInfoWidgetState extends State<homeImageWidget> {
  late bool _isLoading;
  late Timer _timer;
  late bool isFavorite;
  MapListController mapListController = Get.find<MapListController>();

  @override
  void initState() {
    // Check if property with the same ID exists in favoriteProperties
    isFavorite = mapListController.favoriteProperties
        .any((favProperty) => favProperty.id == widget.property.id);
    print(widget.property);
    print(isFavorite);
    print(mapListController.favoriteProperties.length);

    _isLoading = true;
    _timer = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_isLoading)
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
              child: Image.network(
                widget.property.propertyFiles![0].downloadUrls!,
                width: double.infinity,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          )
        else
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
                child: Image.network(
                  widget.property.propertyFiles![0].downloadUrls!,
                  width: double.infinity,
                  height: 190,
                  fit: BoxFit.cover,
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
                      mapListController.favoriteProperties.removeWhere(
                          (favProperty) =>
                              favProperty.id == widget.property.id);
                      snackBar = const SnackBar(
                        content: Text("Removed Successfully"),
                        backgroundColor: Colors.red,
                      );
                    }

                    // If it is not in favourites
                    else {
                      setState(() {
                        isFavorite = true;
                      });
                      mapListController.favoriteProperties.add(widget.property);
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
                        size: 23,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
