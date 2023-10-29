import 'package:client/controller/map_list_controller.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    currentCameraPosition = controller.currentCameraPosition ?? jerusalem;
  }

  Future<void> updateMarkers(double zoom) async {
    if (mapController == null) {
      return;
    }

    final LatLngBounds? bounds = await mapController!.getVisibleRegion();
    if (bounds == null) {
      return;
    }

    final LatLng southwest = bounds.southwest;
    final LatLng northeast = bounds.northeast;

    Set<Marker> visibleMarkers = markerLocations
        .where((marker) =>
            marker.position.latitude >= southwest.latitude &&
            marker.position.latitude <= northeast.latitude &&
            marker.position.longitude >= southwest.longitude &&
            marker.position.longitude <= northeast.longitude)
        .map((marker) => marker.toMarker())
        .toSet();

    setState(() {
      controller.markers.clear();
      if (zoom >= 11) {
        controller.markers.addAll(visibleMarkers);
      }
      currentCameraPosition = CameraPosition(
        target: LatLng(
          (southwest.latitude + northeast.latitude) / 2,
          (southwest.longitude + northeast.longitude) / 2,
        ),
        zoom: zoom,
      );
      controller.currentCameraPosition =
          currentCameraPosition; // Save the camera position
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
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
    position: LatLng(31.527837, 35.0865029),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '2',
    position: LatLng(31.527435, 35.0865435),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '3',
    position: LatLng(31.524345, 35.08643554),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '4',
    position: LatLng(31.524545, 35.0864345),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '5',
    position: LatLng(31.854345, 35.4643344),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '6',
    position: LatLng(31.8544535, 35.46445453),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '7',
    position: LatLng(31.854354, 35.4648335),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '8',
    position: LatLng(31.8544354, 35.46484334),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '9',
    position: LatLng(32.4384345, 35.29243545),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '10',
    position: LatLng(32.4383432, 35.2923434),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '11',
    position: LatLng(32.43834553, 35.29534545),
    icon: BitmapDescriptor.defaultMarker,
  ),
  MapMarker(
    id: '12',
    position: LatLng(32.438945, 35.29543554),
    icon: BitmapDescriptor.defaultMarker,
  ),
];
