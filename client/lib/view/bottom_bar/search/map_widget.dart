import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController? mapController;

  CameraPosition jerusalem = const CameraPosition(
    target: LatLng(32.438909, 35.295625),
    zoom: 8,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: jerusalem,
      onMapCreated: (controller) {
        setState(() {
          mapController = controller;
        });
      },
    );
  }
}
