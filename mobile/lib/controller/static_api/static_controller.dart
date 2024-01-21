import 'package:client/model/location.dart';
import 'package:client/model/property.dart';
import 'package:get/get.dart';

class StaticController extends GetxController {
  List<Property> favoriteProperties = <Property>[];
  List<Property> searchProperties = <Property>[];
  List<Location> searchLocation = <Location>[];

  clearsearchProperties() {
    searchProperties.clear();
    update();
  }

  clearsearchLocation() {
    searchLocation.clear();
    update();
  }
}
