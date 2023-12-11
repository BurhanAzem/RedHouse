import 'package:client/core/class/statusrequest.dart';
import 'package:client/data/properties.dart';
import 'package:client/model/property.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ManagePropertiesController extends GetxController {
  int propertiesUserId = 0;
  List<Property> userProperties = [];

  GlobalKey<FormState> formKey1 = GlobalKey<FormState>(); // In AddProperty1
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>(); // In AddNeighbour
  GoogleMapController? mapController1; // In AddProperty1
  GoogleMapController? mapController2; // In AddNeighbour
  int activeStep = 0;

  late TextEditingController price;
  late TextEditingController numberOfBedrooms;
  late TextEditingController numberOfBathrooms;
  late TextEditingController squareMeter;
  late TextEditingController propertyDescription;
  DateTime builtYear = DateTime(2000);
  String propertyType = "House";
  String view = "City";
  DateTime availableDate = DateTime(2023);
  String propertyStatus = "Accepting offers";
  TextEditingController? numberOfUnits;
  late TextEditingController parkingSpots;
  String listingType = "For sell";
  String isAvaliableBasement = "Yes";
  late TextEditingController streetAddress;
  String listingBy = "Landlord";
  int userId = 0;
  List<String> downloadUrls = [];
  StatusRequest statusRequest = StatusRequest.loading;

  String? City;
  String? Region;
  late String PostalCode;
  String? Country;
  double? Latitude;
  double? Longitude;

  CameraPosition? currentPosition;
  Set<Marker> markers = {}; // Empty marker

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

  @override
  AddProperty() async {
    if (formKey1.currentState!.validate()) {
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

        // For location
        streetAddress.text,
        City!,
        Region!,
        PostalCode,
        Country!,
        Latitude,
        Longitude,
      );

      if (response['statusCode'] == 200) {
        print("================================================== LsitDto");
        print(response['listDto']);
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

  // ALL this for front end
  void increaseActiveStep() {
    activeStep++;
    update();
  }

  void decreaseActiveStep() {
    activeStep--;
    update();
  }

  Widget easyStepper() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: EasyStepper(
        finishedStepBackgroundColor: const Color(0xffd92328),
        activeStepBorderColor: Colors.black,
        stepShape: StepShape.circle,
        lineStyle: const LineStyle(),

        activeStep: activeStep,
        activeStepTextColor: Colors.black87,
        finishedStepTextColor: Colors.black87,
        internalPadding: 0,
        fitWidth: true,
        showLoadingAnimation: false,
        stepRadius: 5,
        showStepBorder: false,
        steps: [
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                    activeStep >= 1 ? const Color(0xffd92328) : Colors.grey,
              ),
            ),
            topTitle: true,
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                    activeStep >= 2 ? const Color(0xffd92328) : Colors.grey,
              ),
            ),
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                    activeStep >= 3 ? const Color(0xffd92328) : Colors.grey,
              ),
            ),
            topTitle: true,
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                    activeStep >= 4 ? const Color(0xffd92328) : Colors.grey,
              ),
            ),
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                    activeStep >= 5 ? const Color(0xffd92328) : Colors.grey,
              ),
            ),
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                    activeStep >= 6 ? const Color(0xffd92328) : Colors.grey,
              ),
            ),
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                    activeStep >= 7 ? const Color(0xffd92328) : Colors.grey,
              ),
            ),
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                    activeStep >= 8 ? const Color(0xffd92328) : Colors.grey,
              ),
            ),
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                    activeStep >= 9 ? const Color(0xffd92328) : Colors.grey,
              ),
            ),
          ),
        ],

        // ON Step Reached
        onStepReached: (index) {
          activeStep = index;
          update();
        },
      ),
    );
  }
}
