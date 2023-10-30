import 'package:client/controller/map_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluster/fluster.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  MapListController controller = Get.put(MapListController());
  GoogleMapController? mapController;
  CameraPosition jerusalem =
      const CameraPosition(target: LatLng(32.438909, 35.295625), zoom: 8);
  CameraPosition? currentCameraPosition;
  String? currentLocationName;
  bool isLoading = true;
  bool userNotified = false;
  String snackBarMessage = "Please zoom in on the map";

  @override
  void initState() {
    super.initState();
    currentCameraPosition = controller.currentCameraPosition ?? jerusalem;

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> updateMarkers(double zoom) async {
    print("========================================================Zoom $zoom");

    if (mapController == null) {
      return;
    }

    final LatLngBounds? bounds = await mapController!.getVisibleRegion();
    if (bounds == null) {
      return;
    }

    if (zoom < 13) {
      if (!userNotified) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(snackBarMessage),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(6),
          margin: EdgeInsets.only(left: 8, right: 8, bottom: 2),
        ));
        userNotified = true;
      }
    }

    final LatLng centerCoordinates = LatLng(
      (bounds.southwest.latitude + bounds.northeast.latitude) / 2,
      (bounds.southwest.longitude + bounds.northeast.longitude) / 2,
    );

    Set<Marker> visibleMarkers = markerLocations
        .where((marker) =>
            marker.position.latitude >= bounds.southwest.latitude &&
            marker.position.latitude <= bounds.northeast.latitude &&
            marker.position.longitude >= bounds.southwest.longitude &&
            marker.position.longitude <= bounds.northeast.longitude)
        .map((marker) => marker.toMarker())
        .toSet();

    setState(() {
      controller.markers.clear();
      if (zoom >= 13) {
        controller.markers.addAll(visibleMarkers);
        reverseGeocode(centerCoordinates);
      }
      currentCameraPosition = CameraPosition(
        target: centerCoordinates,
        zoom: zoom,
      );
      controller.currentCameraPosition = currentCameraPosition;
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
    } catch (e) {
      print('Error during reverse geocoding: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: currentCameraPosition ?? jerusalem,
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
            });
          },
          markers: controller.markers,
          onCameraMove: (CameraPosition position) {
            updateMarkers(position.zoom);
          },
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
  final String id;
  final LatLng position;
  final BitmapDescriptor icon;

  MapMarker({
    required this.id,
    required this.position,
    required this.icon,
    isCluster = false,
    clusterId,
    pointsSize,
    childMarkerId,
  }) : super(
          markerId: id,
          latitude: position.latitude,
          longitude: position.longitude,
          isCluster: isCluster,
          clusterId: clusterId,
          pointsSize: pointsSize,
          childMarkerId: childMarkerId,
        );

  Marker toMarker() => Marker(
        markerId: MarkerId(id),
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
        icon: icon,
      );
}

final List<MapMarker> markerLocations = [
  MapMarker(
    id: '1',
    position: const LatLng(31.527837, 35.0865029),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '2',
    position: const LatLng(31.527435, 35.0865435),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '3',
    position: const LatLng(31.524345, 35.08643554),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '4',
    position: const LatLng(31.524545, 35.0864345),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '5',
    position: const LatLng(31.854345, 35.4643344),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '6',
    position: const LatLng(31.8544535, 35.46445453),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '7',
    position: const LatLng(31.854354, 35.4648335),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '8',
    position: const LatLng(31.8544354, 35.46484334),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '9',
    position: const LatLng(32.4384345, 35.29243545),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '10',
    position: const LatLng(32.4383432, 35.2923434),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '11',
    position: const LatLng(32.43834553, 35.29534545),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '12',
    position: const LatLng(32.438945, 35.29543554),
    icon: BitmapDescriptor.defaultMarker,
  ),
];
