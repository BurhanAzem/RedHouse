import 'dart:async';
import 'package:client/controller/map_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  MapListController mapListController = Get.put(MapListController());
  GoogleMapController? mapController;
  late Timer _timer;
  MapType currentMapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    mapListController.isLoading = true;
    _timer = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          mapListController.isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            // initialCameraPosition: mapListController.currentPosition,
            initialCameraPosition: const CameraPosition(
                target: LatLng(31.776752, 35.224851), zoom: 8),
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
            markers: mapListController.visibleMarkers,
            onCameraMove: (CameraPosition position) {
              mapListController.newZoom = position.zoom;
              print(mapListController.newZoom);
              print(position);
              // whenCameraMove();
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
