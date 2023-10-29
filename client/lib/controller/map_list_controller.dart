import 'package:client/model/property.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapListController extends GetxController {
  Set<Marker> markers = Set<Marker>();
  CameraPosition? currentCameraPosition;
  String currentLocationName = '';

  List<Property> Properties = [];
}
