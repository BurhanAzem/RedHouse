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
  MapListController controller = Get.put(MapListController());
  GoogleMapController? mapController;
  CameraPosition _currentPosition =
      const CameraPosition(target: LatLng(31.776752, 35.224851), zoom: 8);
  bool isLoading = true;
  bool isLoadingMap = false;
  bool userNotified = false;
  String snackBarMessage = "You are too far out, please zoom in";

  @override
  void initState() {
    super.initState();
    _currentPosition = controller.currentPosition ?? _currentPosition;
    controller.allMarkers =
        controller.getMarkerLocations(controller.allProperties);

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

  Future<void> updateMarkers(double zoom) async {
    print("======================================================== markers");
    print(controller.allMarkers);
    print("========================================================Zoom $zoom");

    if (mapController == null) {
      return;
    }

    final LatLngBounds? bounds = await mapController!.getVisibleRegion();
    if (bounds == null) {
      return;
    }

    if (zoom < 12) {
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

    Set<Property> newVisibleProperties = controller.allProperties
        .where((property) =>
            property.PropertyLocation!.Latitude! >= bounds.southwest.latitude &&
            property.PropertyLocation!.Latitude! <= bounds.northeast.latitude &&
            property.PropertyLocation!.Longitude! >=
                bounds.southwest.longitude &&
            property.PropertyLocation!.Longitude! <= bounds.northeast.longitude)
        .toSet();

    Set<Marker> visibleMarkers = controller.allMarkers
        .where((marker) =>
            marker.position.latitude >= bounds.southwest.latitude &&
            marker.position.latitude <= bounds.northeast.latitude &&
            marker.position.longitude >= bounds.southwest.longitude &&
            marker.position.longitude <= bounds.northeast.longitude)
        .map((marker) => marker.toMarker())
        .toSet();

    setState(() {
      controller.visibleMarkers.clear();
      controller.visibleProperties.clear();
      if (zoom >= 12) {
        controller.visibleMarkers.addAll(visibleMarkers);
        controller.visibleProperties.addAll(newVisibleProperties);
        reverseGeocode(centerCoordinates);
      }
      _currentPosition = CameraPosition(
        target: centerCoordinates,
        zoom: zoom,
      );
      controller.currentPosition = _currentPosition;
    });
  }

  Future<void> reverseGeocode(LatLng coordinates) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        coordinates.latitude,
        coordinates.longitude,
      );
      if (placemarks.isNotEmpty) {
        controller.currentLocationName.value =
            "Area in ${placemarks[0].locality ?? ''}";
        print('Location Name: ${controller.currentLocationName}');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    controller.mapContext = context;

    return Stack(
      children: [
        Visibility(
          visible: isLoadingMap,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _currentPosition,
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
            markers: controller.visibleMarkers,
            onCameraMove: (CameraPosition position) {
              updateMarkers(position.zoom);
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
      markerId: MarkerId(property.PropertyId.toString()),
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
                height: MediaQuery.of(context).size.height / 2, //2.3
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
                            child: Image.asset(
                              property.PropertyFiles![0],
                              width: double.infinity,
                              height: 190,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            right: 16,
                            child: InkWell(
                              onTap: () {
                                print(
                                    "=============================================================love");
                              },
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
                        padding: const EdgeInsets.only(left: 25, top: 15),
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
                                    color: Color.fromARGB(255, 44, 162, 46),
                                  ),
                                ),
                                Text(
                                  " ${property.PropertyStatus}",
                                  style: const TextStyle(fontSize: 17.5),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "ID = ${property.PropertyId}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              "\$${NumberFormat.decimalPattern().format(property.Price)}${property.PropertyStatus == "For Rent" ? "/mo" : ""}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "${property.NumberOfBedRooms} bedroom, ${property.NumberOfBathRooms} bathroom, ${NumberFormat.decimalPattern().format(property.SquareMeter)} meters",
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "${property.PropertyLocation!.StreetAddress}, ${property.PropertyLocation!.City}, ${property.PropertyLocation!.Country}",
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              (property.PropertyDescription!.length <= 100)
                                  ? property.PropertyDescription!
                                  : '${property.PropertyDescription!.substring(0, 45)}...',
                              style: const TextStyle(),
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
