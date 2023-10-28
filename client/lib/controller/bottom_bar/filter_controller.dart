import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  bool listingType = true; // true --> Buy, false --> Rent

  bool buyHouse = true;
  bool buyHouseTemp = true;
  bool buyApartment = true;
  bool buyApartmentTemp = true;
  bool buyTownhouse = true;
  bool buyTownhouseTemp = true;
  bool buyCastle = true;
  bool buyCastleTemp = true;
  bool buyDepartment = true;
  bool buyDepartmentTemp = true;

  bool rentHouse = true;
  bool rentHouseTemp = true;
  bool rentApartment = true;
  bool rentApartmentTemp = true;
  bool rentTownhouse = true;
  bool rentTownhouseTemp = true;
  bool rentCastle = true;
  bool rentCastleTemp = true;
  bool rentDepartment = true;
  bool rentDepartmentTemp = true;

  final buyMaxController = TextEditingController();
  final buyMinController = TextEditingController();
  final rentMaxController = TextEditingController();
  final rentMinController = TextEditingController();
  final buyMaxControllerTemp = TextEditingController();
  final buyMinControllerTemp = TextEditingController();
  final rentMaxControllerTemp = TextEditingController();
  final rentMinControllerTemp = TextEditingController();

  String buyView = "Any view";
  String buyViewTemp = "";
  String rentView = "Any view";
  String rentViewTemp = "";

  RxString bedButtonTemp = "Any".obs;
  RxString bedButton = "Any".obs;
  RxString bathButtonTemp = "Any".obs;
  RxString bathButton = "Any".obs;

  final List<String> bedroomLabels = [
    'Any',
    'Studio+',
    '1+',
    '2+',
    '3+',
    '4+',
    '5+',
  ];

  final List<String> bathroomLabels = [
    'Any',
    '1+',
    '2+',
    '3+',
    '4+',
    '5+',
  ];

  void setBedButtonTemp(String label) {
    bedButtonTemp.value = label;
  }

  void setBathButtonTemp(String label) {
    bathButtonTemp.value = label;
  }

  bool isBedButtonTemp(String label) {
    return bedButtonTemp.value == label;
  }

  bool isBathButtonTemp(String label) {
    return bathButtonTemp.value == label;
  }

  void copyBedButton() {
    bedButton.value = bedButtonTemp.value;
  }

  void copyBathButton() {
    bathButton.value = bathButtonTemp.value;
  }

  void copyBedButtonTemp() {
    bedButtonTemp.value = bedButton.value;
  }

  void copyBathButtonTemp() {
    bathButtonTemp.value = bathButton.value;
  }
}
