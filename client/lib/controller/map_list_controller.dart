import 'package:client/model/property.dart';
import 'package:client/view/search/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapListController extends GetxController {
  CameraPosition currentPosition =
      const CameraPosition(target: LatLng(31.776752, 35.224851), zoom: 8);
  RxString currentLocationName = "".obs;
  double newZoom = 0.0;
  BuildContext? mapContext;

  List<MapMarker> allMarkers = [];
  Set<Marker> visibleMarkers = <Marker>{};
  Set<Property> visibleProperties = <Property>{};

  bool? isLoading;
  bool? isLoadingImage;
  bool isListIcon = true;

  // Favorite properties
  List<Property> favoriteProperties = <Property>[];
}
