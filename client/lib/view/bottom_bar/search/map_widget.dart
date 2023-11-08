import 'package:client/controller/account_info_contoller.dart';
import 'package:client/controller/bottom_bar/filter_controller.dart';
import 'package:client/controller/map_list_controller.dart';
import 'package:client/model/property.dart';
import 'package:client/view/bottom_bar/search/home%20information/home_information.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluster/fluster.dart';
import 'package:intl/intl.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  AccountInfoContoller accountController = Get.put(AccountInfoContoller());
  MapListController mapListController = Get.put(MapListController());
  FilterController filterControllerr = Get.put(FilterController());
  GoogleMapController? mapController;
  bool isLoading = true;
  bool isLoadingMap = false;
  bool userNotified = false;
  String snackBarMessage = "You are too far out, please zoom in";

  @override
  void initState() {
    super.initState();
    mapListController.allMarkers = filterControllerr
        .getMarkerLocations(filterControllerr.listProperty.listDto);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoadingMap = true;
      });
    });
  }

  Future<void> updateMarkers() async {
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

    Set<Property> newVisibleProperties = filterControllerr.listProperty.listDto
        .where((property) =>
            property.UserId != accountController.userDto?["id"] &&
            property.location.Latitude >= bounds.southwest.latitude &&
            property.location.Latitude <= bounds.northeast.latitude &&
            property.location.Longitude >= bounds.southwest.longitude &&
            property.location.Longitude <= bounds.northeast.longitude)
        .toSet();

    Set<Marker> visibleMarkers = mapListController.allMarkers
        .where((marker) =>
            marker.position.latitude >= bounds.southwest.latitude &&
            marker.position.latitude <= bounds.northeast.latitude &&
            marker.position.longitude >= bounds.southwest.longitude &&
            marker.position.longitude <= bounds.northeast.longitude)
        .map((marker) => marker.toMarker())
        .toSet();

    setState(() {
      mapListController.visibleMarkers.clear();
      mapListController.visibleProperties.clear();
      if (mapListController.newZoom >= 10) {
        mapListController.visibleMarkers.addAll(visibleMarkers);
        mapListController.visibleProperties.addAll(newVisibleProperties);
        reverseGeocode(centerCoordinates);
      }
      mapListController.currentPosition = CameraPosition(
        target: centerCoordinates,
        zoom: mapListController.newZoom,
      );
    });
    mapListController.allMarkers = filterControllerr
        .getMarkerLocations(filterControllerr.listProperty.listDto);
  }

  Future<void> reverseGeocode(LatLng coordinates) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        coordinates.latitude,
        coordinates.longitude,
      );
      if (placemarks.isNotEmpty) {
        var city = placemarks[0].administrativeArea ?? '';
        mapListController.currentLocationName.value =
            "Area in ${placemarks[0].locality ?? ''}";

        if (city != filterControllerr.currentCity) {
          filterControllerr.currentCity =
              placemarks[0].administrativeArea ?? '';
          print(
              "=====================================================================Call to api");
          filterControllerr.getProperties();
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    mapListController.mapContext = context;

    return Stack(
      children: [
        Visibility(
          visible: isLoadingMap,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: mapListController.currentPosition,
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
            markers: mapListController.visibleMarkers,
            onCameraMove: (CameraPosition position) {
              print("============================================Camera move");
              mapListController.newZoom = position.zoom;
              updateMarkers();
            },
          ),
        ),
        Visibility(
          visible: isLoading,
          child: const LinearProgressIndicator(
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 2),
        ),
      ],
    );
  }
}

class MapMarker extends Clusterable {
  MapListController controller = Get.put(MapListController());
  FilterController filterController = Get.put(FilterController());

  Property property;
  final LatLng position;

  MapMarker({
    required this.property,
    required this.position,
  });

  get context => null;

  Marker toMarker() => Marker(
      markerId: MarkerId(property.Id.toString()),
      position: LatLng(
        position.latitude,
        position.longitude,
      ),
      icon: filterController.listingType
          ? BitmapDescriptor.defaultMarker
          : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      onTap: () {
        _showMarkerInfo(property);
      });

  void _showMarkerInfo(Property property) {
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
                height: MediaQuery.of(context).size.height / 2.15,
                width: 500,
                child: InkWell(
                  onTap: () {
                    Get.to(() => HomeInformation(property: property));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(30)),
                            child: Image.network(
                              property.PropertyFiles[0].DownloadUrls!,
                              width: double.infinity,
                              height: 190,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            right: 16,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.black,
                                    size: 23,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                                  " ${property.ListingType}",
                                  style: const TextStyle(fontSize: 17.5),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "\$${NumberFormat.decimalPattern().format(property.Price)}${property.ListingType == "For rent" ? "/mo" : ""}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(height: 6),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${property.NumberOfBedRooms} ',
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
                                    text: '${property.NumberOfBathRooms} ',
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
                              "${property.location.StreetAddress}, ${property.location.City}, ${property.location!.Country}",
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              property.PropertyDescription,
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
