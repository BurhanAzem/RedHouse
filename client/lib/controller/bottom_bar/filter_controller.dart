import 'package:client/core/class/statusrequest.dart';
import 'package:client/data/properties.dart';
import 'package:client/model/location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  bool listingType = true; // true --> Buy, false --> Rent

  Location? location = Location(
    StreetAddress: "",
    City: "",
    Region: "",
    PostalCode: "",
    Country: "",
    Latitude: 0.0,
    Longitude: 0.0,
  );

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

  String buyView = "Any";
  String buyViewTemp = "";

  String rentView = "Any";
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

  getProperties() async {
    List<String>? propertyTypes = [];
    String? minPrice;
    String? maxPrice;
    String? numberOfBathrooms;
    String? numberOfBedrooms;
    String? view;
    String? listingPropertyType;

    if (listingType) {
      if (buyHouse)
        propertyTypes!.add("House");
      else
        propertyTypes!.add("");
      if (buyApartment)
        propertyTypes!.add("Apartment Unit");
      else
        propertyTypes!.add("");
      if (buyTownhouse)
        propertyTypes!.add("Townhouse");
      else
        propertyTypes!.add("");
      if (buyCastle)
        propertyTypes!.add("Castle");
      else
        propertyTypes!.add("");
      if (buyDepartment)
        propertyTypes!.add("Entire Department Community");
      else
        propertyTypes!.add("");
      minPrice = buyMinController.text;
      maxPrice = buyMaxController.text;
      view = buyView;
    } else {
      if (rentHouse)
        propertyTypes!.add("House");
      else
        propertyTypes!.add("");
      if (rentApartment)
        propertyTypes!.add("Apartment Unit");
      else
        propertyTypes!.add("");
      if (rentTownhouse)
        propertyTypes!.add("Townhouse");
      else
        propertyTypes!.add("");
      if (rentCastle)
        propertyTypes!.add("Castle");
      else
        propertyTypes!.add("");
      if (rentDepartment)
        propertyTypes!.add("Entire Department Community");
      else
        propertyTypes!.add("");

      minPrice = rentMinController.text;
      maxPrice = rentMaxController.text;
      view = rentView;
    }

    if (bedButton.toString().length <= 2)
      numberOfBedrooms = bedButton.string.substring(0, 1);
    else
      numberOfBedrooms = "";

    if (bathButton.toString().length <= 2)
      numberOfBathrooms = bathButton.string.substring(0, 1);
    else
      numberOfBathrooms = "";
    // Rest of your code
    if (listingType)
      listingPropertyType = "For sell";
    else
      listingPropertyType = "For rent";
    var response = await PropertyData.getdata(
        propertyTypes,
        minPrice,
        maxPrice,
        numberOfBathrooms,
        numberOfBedrooms,
        view,
        listingPropertyType.toString(),
        location!);

    if (response['statusCode'] == 200) {
      print("================================================== LsitDto");
      print(response["listDto"]);

      // Get.offNamed(AppRoute.verfiyCodeSignUp);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

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
