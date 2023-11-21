import 'package:client/core/class/statusrequest.dart';
import 'package:client/data/properties.dart';
import 'package:client/model/property.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ManagePropertyController extends GetxController {
  ManagePropertyController();
  goToAddProperty1();
  goToAddProperty2();
  goToAddProperty3();
  goToAddProperty4();
  goToAddProperty5();
  goToAddProperty6();
  goToAddProperty7();
  goToAddProperty8();
  goToAddProperty9();
}

class ManagePropertyControllerImp extends ManagePropertyController {
  int propertiesUserId = 0;
  List<Property> userProperties = [];

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  int activeStep = 0;
  late TextEditingController price;
  late TextEditingController numberOfBedrooms;
  late TextEditingController numberOfBathrooms;
  late TextEditingController squareMeter;
  late TextEditingController propertyDescription;
  DateTime builtYear = DateTime(1900);
  String propertyType = "House";
  String view = "City";
  DateTime availableDate = DateTime(2023);
  String propertyStatus = "Accepting offers";
  TextEditingController? numberOfUnits;
  late TextEditingController parkingSpots;
  String listingType = "For rent";
  String isAvaliableBasement = "Yes";
  late TextEditingController streetAddress;
  String listingBy = "Landlord";
  int userId = 0;
  List<String> downloadUrls = [];
  // PropertyData propertyData = PropertyData(Crud());
  StatusRequest statusRequest = StatusRequest.loading;

  String? City;
  String? Region;
  late String PostalCode;
  String? Country;
  double? Latitude;
  double? Longitude;

  List data = [];

  @override
  AddProperty() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      var response = await PropertyData.addProperty(
          propertyType,
          price.text,
          numberOfBedrooms.text,
          numberOfBathrooms.text,
          squareMeter.text,
          propertyDescription.text,
          builtYear,
          view,
          availableDate,
          propertyStatus,
          numberOfUnits?.text ?? "",
          parkingSpots.text,
          listingType,
          isAvaliableBasement,
          listingBy,
          userId,
          downloadUrls,
          streetAddress.text,
          City!,
          Region!,
          PostalCode,
          Country!,
          Latitude,
          Longitude);

      if (response['statusCode'] == 200) {
        print("================================================== LsitDto");
        print(response['listDto']);

        // Get.offNamed(AppRoute.verfiyCodeSignUp);
      } else {
        Get.defaultDialog(
          title: "Error",
          middleText:
              "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
        );
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    price = TextEditingController();
    numberOfBedrooms = TextEditingController();
    numberOfBathrooms = TextEditingController();
    squareMeter = TextEditingController();
    propertyDescription = TextEditingController();
    view = "City";
    availableDate = DateTime(2023);
    propertyStatus = "Accepting offers";
    numberOfUnits = TextEditingController();
    parkingSpots = TextEditingController();
    streetAddress = TextEditingController();
    listingBy = "Landlord";
    activeStep = 0;
    super.onInit();
  }

  getPropertiesUser() async {
    var response = await PropertyData.getPropertiesForUser(propertiesUserId);
  
    if (response['statusCode'] == 200) {
      userProperties = (response['listDto'] as List<dynamic>)
          .map((e) => Property.fromJson(e as Map<String, dynamic>))
          .toList();
      print(userProperties);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

  @override
  goToAddProperty1() {
    Get.toNamed(AppRoute.addProperty1);
  }

  @override
  goToAddProperty2() {
    Get.toNamed(AppRoute.addProperty2);
  }

  @override
  goToAddProperty3() {
    Get.toNamed(AppRoute.addProperty3);
  }

  @override
  goToAddProperty4() {
    Get.toNamed(AppRoute.addProperty4);
  }

  @override
  goToAddProperty5() {
    Get.toNamed(AppRoute.addProperty5);
  }

  @override
  goToAddProperty6() {
    Get.toNamed(AppRoute.addProperty6);
  }

  @override
  goToAddProperty7() {
    Get.toNamed(AppRoute.addProperty7);
  }

  @override
  goToAddProperty8() {
    Get.toNamed(AppRoute.addProperty8);
  }

  @override
  goToAddProperty9() {
    Get.toNamed(AppRoute.addProperty9);
  }
}
