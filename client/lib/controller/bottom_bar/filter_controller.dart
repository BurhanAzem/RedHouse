import 'dart:convert';

import 'package:client/core/class/statusrequest.dart';
import 'package:client/data/properties.dart';
import 'package:client/model/list_property.dart';
import 'package:client/model/location.dart';
import 'package:client/model/property.dart';
import 'package:client/view/bottom_bar/search/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FilterController extends GetxController {
  bool listingType = false; // true --> Buy, false --> Rent
  ListProperty? listProperty;
  Rx<Location> location = Location(
    Id: 0,
    StreetAddress: "",
    City: "",
    Region: "",
    PostalCode: "",
    Country: "",
    Latitude: 0,
    Longitude: 0,
  ).obs;

  bool buyHouse = false;
  bool buyHouseTemp = false;
  bool buyApartment = false;
  bool buyApartmentTemp = false;
  bool buyTownhouse = false;
  bool buyTownhouseTemp = false;
  bool buyCastle = false;
  bool buyCastleTemp = false;
  bool buyDepartment = false;
  bool buyDepartmentTemp = false;

  bool rentHouse = false;
  bool rentHouseTemp = false;
  bool rentApartment = false;
  bool rentApartmentTemp = false;
  bool rentTownhouse = false;
  bool rentTownhouseTemp = false;
  bool rentCastle = false;
  bool rentCastleTemp = false;
  bool rentDepartment = false;
  bool rentDepartmentTemp = false;

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
      // else
      //   propertyTypes!.add("");
      if (buyApartment)
        propertyTypes!.add("Apartment Unit");
      // else
      //   propertyTypes!.add("");
      if (buyTownhouse)
        propertyTypes!.add("Townhouse");
      // else
      //   propertyTypes!.add("");
      if (buyCastle)
        propertyTypes!.add("Castle");
      // else
      //   propertyTypes!.add("");
      if (buyDepartment)
        propertyTypes!.add("Entire Department Community");
      // else
      //   propertyTypes!.add("");
      minPrice = buyMinController.text;
      maxPrice = buyMaxController.text;
      view = buyView;
    } else {
      if (rentHouse)
        propertyTypes!.add("House");
      // else
      //   propertyTypes!.add("");
      if (rentApartment)
        propertyTypes!.add("Apartment Unit");
      // else
      //   propertyTypes!.add("");
      if (rentTownhouse)
        propertyTypes!.add("Townhouse");
      // else
      //   propertyTypes!.add("");
      if (rentCastle)
        propertyTypes!.add("Castle");
      // else
      //   propertyTypes!.add("");
      if (rentDepartment)
        propertyTypes!.add("Entire Department Community");
      // else
      //   propertyTypes!.add("");

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
      // final Map<String, dynamic> listDto = response['listDto'];
      // if (listDto is List) {
        // Cast each item to a map
        listProperty =  ListProperty.fromJson(response);
        print(listProperty!.listDto);
      // } else {
      //   Get.defaultDialog(
      //     title: "Error",
      //     middleText: "Invalid data format in 'listDto'",
      //   );
      // }
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

  List<MapMarker> getMarkerLocations(List<Property> properties) {
    return properties.map((property) {
      return MapMarker(
        property: property,
        position: LatLng(
          property.location?.Latitude ?? 0.0,
          property.location?.Longitude ?? 0.0,
        ),
      );
    }).toList();
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