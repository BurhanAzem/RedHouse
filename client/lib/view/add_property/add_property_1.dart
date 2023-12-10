import 'dart:async';
import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/view/add_property/add_property_neighbour.dart';
import 'package:geocoding/geocoding.dart';
import 'package:client/controller/manage_propertise/manage_properties_controller.dart';
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
  bool arePlacemarksAvailable = false;
  final geocoding = GeocodingPlatform.instance;
  late double lat;
  late double long;
  Position? cl;

  StreamSubscription<Position>? positionStream;

  ManagePropertiesController controller =
      Get.put(ManagePropertiesController(), permanent: true);

  LoginControllerImp loginController = Get.put(LoginControllerImp());

  Future<void> getLatAndLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl!.latitude;
    long = cl!.longitude;
    controller.currentPosition =
        CameraPosition(target: LatLng(lat, long), zoom: 13);
  }

  @override
  void initState() {
    getLatAndLong();

    // Clear all previous values
    setState(() {
      controller.markers = {};
      controller.activeStep = 1;
      controller.price.text = '';
      controller.numberOfBedrooms.text = '';
      controller.numberOfBathrooms.text = '';
      controller.squareMeter.text = '';
      controller.propertyDescription.text = '';
      controller.builtYear = DateTime(2000);
      controller.availableDate = DateTime(2023);
      controller.propertyStatus = "Accepting offers";
      controller.numberOfUnits!.text = '';
      controller.parkingSpots.text = '';
      controller.listingType = "For sell";
      controller.isAvaliableBasement = "Yes";
      controller.streetAddress.text = "";
      controller.downloadUrls = [];
    });

    positionStream = Geolocator.getPositionStream().listen(
      (Position? position) {
        print(position == null
            ? 'Unknown'
            : '${position.latitude.toString()}, ${position.longitude.toString()}');
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    getLatAndLong();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagePropertiesController>(
      init: ManagePropertiesController(),
      builder: (ManagePropertiesController controller) {
        return Scaffold(
          // App bar
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  controller.decreaseActiveStep();
                  print(controller.activeStep);
                  Navigator.pop(context);
                });
              },
            ),
            title: RichText(
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "Add ",
                    style: TextStyle(
                      color: Color(0xffd92328),
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "Property",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    minWidth: 0,
                    onPressed: arePlacemarksAvailable
                        ? () {
                            setState(() {
                              controller.increaseActiveStep();
                              print(controller.activeStep);
                              controller.userId =
                                  loginController.userDto?["id"];
                              Get.to(() => AddPropertyNeighbour());
                            });
                          }
                        : () {},
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: arePlacemarksAvailable
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Body
          body: Container(
            margin: const EdgeInsets.all(15),
            child: Form(
              key: controller.formKey1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.easyStepper(),

                  // Introduction
                  Image.asset("assets/images/logo.png", scale: 11),
                  Container(
                    child: const Text(
                      "Locate your property on the map",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),

                  // Google Map
                  Container(height: 30),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(border: Border.all()),
                    height: 300,
                    child: Visibility(
                      visible: true,
                      child: controller.currentPosition == null
                          ? Container(
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator())
                          : Expanded(
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition:
                                    controller.currentPosition!,
                                onCameraMove: (position) {
                                  controller.currentPosition = CameraPosition(
                                      target: LatLng(position.target.latitude,
                                          position.target.longitude),
                                      zoom: position.zoom);
                                },
                                onMapCreated: (mapcontroller) {
                                  getLatAndLong();
                                  controller.mapController1 = mapcontroller;
                                },
                                markers: controller.markers
                                    .where((marker) =>
                                        marker.markerId.value == "1")
                                    .toSet(),
                                onTap: (latlng) async {
                                  print(controller.markers);

                                  // Remove the marker with the specified ID
                                  controller.markers.removeWhere(
                                    (marker) => marker.markerId.value == "1",
                                  );

                                  // Add a new marker with ID "1"
                                  controller.markers.add(
                                    Marker(
                                      markerId: const MarkerId("1"),
                                      position: latlng,
                                    ),
                                  );
                                  print(controller.markers);
                                  try {
                                    List<Placemark> placemarks =
                                        await placemarkFromCoordinates(
                                            latlng.latitude, latlng.longitude);

                                    if (placemarks.isNotEmpty) {
                                      final placemark = placemarks[0];
                                      controller.City = placemark.locality;
                                      controller.PostalCode =
                                          placemark.postalCode!;
                                      controller.streetAddress.text =
                                          placemark.street!;
                                      controller.Country = placemark.country;
                                      controller.Region = placemark.locality;
                                      controller.Latitude = latlng.latitude;
                                      controller.Longitude = latlng.longitude;

                                      print('City: ${controller.City}');
                                      print(
                                          'PostalCode: ${controller.PostalCode}');
                                      print('Country: ${controller.Country}');
                                      print(
                                          'streetAddress: ${controller.streetAddress.text}');
                                      print('Region: ${controller.Region}');
                                      print('Latitude: ${controller.Latitude}');
                                      print(
                                          'Longitude: ${controller.Longitude}');
                                      arePlacemarksAvailable = true;
                                    }
                                  } catch (e) {
                                    Get.defaultDialog(
                                        title: "ُEntered invalid location",
                                        middleText: 'Error: $e');
                                    arePlacemarksAvailable = false;
                                  }
                                  setState(() {});
                                },
                              ),
                            ),
                    ),
                  ),

                  // Street address
                  Container(height: 20),
                  Container(
                    child: const Text(
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
                    child: TextFormField(
                      controller: controller.streetAddress,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        hintText: "Here will appear Street address",
                        suffixIcon: const Icon(Icons.map),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   alignment: Alignment.center,
                  //   margin: const EdgeInsets.only(left: 12),
                  //   child: Text(
                  //     "Enter the USPS-validated address. You won't be able to edit the address once you create the listing.",
                  //     style: TextStyle(
                  //       fontSize: 11,
                  //       color: Colors.grey[700],
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),
                  // Container(height: 5),
                  // Container(height: 5),
                  // Container(
                  //   alignment: Alignment.center,
                  //   margin: const EdgeInsets.only(left: 12),
                  //   child: MaterialButton(
                  //     minWidth: 400,
                  //     onPressed: arePlacemarksAvailable
                  //         ? () {
                  //             setState(() {
                  //               controller.increaseActiveStep();
                  //               print(controller.activeStep);
                  //             });
                  //             controller.userId =
                  //                 loginController.userDto?["id"];
                  //             Get.to(() => AddPropertyNeighbour());
                  //           }
                  //         : () {},
                  //     color: arePlacemarksAvailable
                  //         ? const Color(0xffd92328)
                  //         : const Color.fromARGB(255, 251, 169, 169),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: const Text(
                  //       "Continue",
                  //       style: TextStyle(
                  //         color: Colors.black,
                  //         fontWeight: FontWeight.w700,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Container(height: 15),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
