import 'package:client/model/property.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapListController extends GetxController {
  Set<Marker> markers = Set<Marker>();
  CameraPosition? currentCameraPosition;
  final RxString currentLocationName = "".obs;

<<<<<<< HEAD
  List<Property> properties = [];
=======
  List<Property> Properties = [];

  
>>>>>>> d19e12219740318d11d500af635f633b653ce0be
}
