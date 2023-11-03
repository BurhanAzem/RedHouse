import 'dart:async';
import 'package:geocoding/geocoding.dart';

import 'package:client/controller/manage_propertise/add_property_controller.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddProperty1 extends StatefulWidget {
  AddProperty1({Key? key}) : super(key: key);

  @override
  _AddProperty1State createState() => _AddProperty1State();
}

class _AddProperty1State extends State<AddProperty1> {
  GoogleMapController? mapController;
  bool arePlacemarksAvailable = false;

  final geocoding = GeocodingPlatform.instance;

  late double lat;
  late double long;
  Position? cl;
  CameraPosition? currentCameraPosition;
  StreamSubscription<Position>? positionStream;
  Set<Marker>? marker = {
    Marker(markerId: MarkerId("1"), position: LatLng(20, 20))
  };
  Future<void> getLatAndLong() async {
    LocationPermission permission = await Geolocator.requestPermission();
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl!.latitude;
    long = cl!.longitude;
    currentCameraPosition = CameraPosition(target: LatLng(lat, long), zoom: 14);
    setState(() {}); // Update the state to rebuild the widget.
  }

  CameraPosition jerusalem = CameraPosition(
    target: LatLng(32.438909, 35.295625),
    zoom: 8,
  );

  @override
  void initState() {
    positionStream =
        Geolocator.getPositionStream().listen((Position? position) {
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });
    getLatAndLong(); // Initialize currentCameraPosition when the widget is created.
    super.initState();
  }

  // final PageController pageController;
  @override
  Widget build(BuildContext context) {
    const options = [
      "House",
      "Apartment Unit",
      "Townhouse",
      "Entire Department Community"
    ];
    AddPropertyControllerImp controller =
        Get.put(AddPropertyControllerImp(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Red",
              style: TextStyle(
                color: Color(0xffd92328),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "House Manage Properties",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Form(
          key: controller.formstate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EasyStepper(
                finishedStepBackgroundColor: Color(0xffd92328),
                activeStepBorderColor: Colors.black,
                stepShape: StepShape.circle,
                lineStyle: LineStyle(),

                activeStep: controller.activeStep,
                activeStepTextColor: Colors.black87,
                finishedStepTextColor: Colors.black87,
                internalPadding: 0,
                // showScrollbar: false,
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
                        backgroundColor: controller.activeStep >= 0
                            ? Color(0xffd92328)
                            : Colors.grey,
                      ),
                    ),
                    // title: 'Waiting',
                  ),
                  EasyStep(
                    customStep: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: controller.activeStep >= 1
                            ? Color(0xffd92328)
                            : Colors.grey,
                      ),
                    ),
                    // title: 'Order Received',
                    topTitle: true,
                  ),
                  EasyStep(
                    customStep: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: controller.activeStep >= 2
                            ? Color(0xffd92328)
                            : Colors.grey,
                      ),
                    ),
                    // title: 'Preparing',
                  ),
                  EasyStep(
                    customStep: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: controller.activeStep >= 3
                            ? Color(0xffd92328)
                            : Colors.grey,
                      ),
                    ),
                    // title: 'On Way',
                    topTitle: true,
                  ),
                  EasyStep(
                    customStep: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: controller.activeStep >= 4
                            ? Color(0xffd92328)
                            : Colors.grey,
                      ),
                    ),
                    // title: 'Delivered',
                  ),
                  EasyStep(
                    customStep: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: controller.activeStep >= 5
                            ? Color(0xffd92328)
                            : Colors.grey,
                      ),
                    ),
                    // title: 'Delivered',
                  ),
                  EasyStep(
                    customStep: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: controller.activeStep >= 6
                            ? Color(0xffd92328)
                            : Colors.grey,
                      ),
                    ),
                    // title: 'Delivered',
                  ),
                  EasyStep(
                    customStep: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: controller.activeStep >= 7
                            ? Color(0xffd92328)
                            : Colors.grey,
                      ),
                    ),
                    // title: 'Delivered',
                  ),
                  EasyStep(
                    customStep: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: controller.activeStep >= 8
                            ? Color(0xffd92328)
                            : Colors.grey,
                      ),
                    ),
                    // title: 'Delivered',
                  ),
                ],
                onStepReached: (index) =>
                    setState(() => controller.activeStep = index),
              ),
              Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Image.asset("assets/images/logo.png", scale: 10)),
              Container(
                margin: EdgeInsets.only(left: 12),
                child: Text(
                  "First, let's add your property",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                ),
              ),
              Container(height: 20),
              Container(
                margin: EdgeInsets.only(left: 12),
                child: Text(
                  "Street address",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(height: 5),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 12),
                child: TextFormField(
                  controller: controller.streetAddress,
                  style: TextStyle(),
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.map),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 12),
                child: Text(
                  "Enter the USPS-validated address. You won't be able to edit the address once you create the listing.",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(height: 5),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(border: Border.all()),
                height: 300,
                child: Visibility(
                  visible: true,
                  child: currentCameraPosition == null
                      ? Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator())
                      : Expanded(
                          child: GoogleMap(
                            markers: marker!,
                            onTap: (latlng) async {
                              marker!.add(Marker(
                                  markerId: MarkerId("9"), position: latlng));
                              try {
                                List<Placemark> placemarks =
                                    await placemarkFromCoordinates(
                                        latlng.latitude, latlng.longitude);

                                if (placemarks.isNotEmpty) {
                                  final placemark = placemarks[0];
                                  controller.City = placemark.locality;
                                  controller.PostalCode = placemark.postalCode!;
                                  controller.streetAddress.text =
                                      placemark.street!;
                                  controller.Country = placemark.country;
                                  controller.Region = placemark.locality;
                                  controller.Latitude = latlng.latitude;
                                  controller.Longitude = latlng.longitude;

                                  print('City: ${controller.City}');
                                  print('PostalCode: ${controller.PostalCode}');
                                  print('Country: ${controller.Country}');
                                  print(
                                      'streetAddress: ${controller.streetAddress.text}');
                                  print('Region: ${controller.Region}');
                                  print('Latitude: ${controller.Latitude}');
                                  print('Longitude: ${controller.Longitude}');
                                  arePlacemarksAvailable = true;
                                  setState(() {
                                    
                                  });
                                }
                              } catch (e) {
                                Get.defaultDialog(
                                    title: "ُEntered invalid location",
                                    middleText: 'Error: $e');
                                arePlacemarksAvailable = false;
                              }
                              setState(() {});
                            },
                            mapType: MapType.normal,
                            initialCameraPosition: jerusalem!,
                            onMapCreated: (mapcontroller) {
                              getLatAndLong();
                              mapController = mapcontroller;
                            },
                          ),
                        ),
                ),
              ),
              Container(height: 5),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 12),
                child: MaterialButton(
                  minWidth: 400,
                  onPressed: arePlacemarksAvailable
                      ? () {
                          setState(() {
                            controller.activeStep++;
                          });
                          controller.goToAddProperty2();
                        }
                      : (){},
                  color:arePlacemarksAvailable ? Color(0xffd92328) : Color.fromARGB(255, 251, 169, 169),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Container(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
