import 'dart:async';
import 'package:client/controller/auth/login_controller.dart';
import 'package:client/view/add_property/add_property_2.dart';
import 'package:client/view/add_property/add_property_neighbour.dart';
import 'package:geocoding/geocoding.dart';
import 'package:client/controller/manage_propertise/manage_property_controller.dart';
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
  CameraPosition? currentCameraPosition;
  StreamSubscription<Position>? positionStream;

  // Empty marker
  Set<Marker> marker = {};

  Future<void> getLatAndLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl!.latitude;
    long = cl!.longitude;
    currentCameraPosition = CameraPosition(target: LatLng(lat, long), zoom: 14);
    setState(() {});
  }

  CameraPosition jerusalem = const CameraPosition(
    target: LatLng(32.438909, 35.295625),
    zoom: 8,
  );

  ManagePropertyControllerImp controller =
      Get.put(ManagePropertyControllerImp(), permanent: true);
  LoginControllerImp loginController = Get.put(LoginControllerImp());

  @override
  void initState() {
    setState(() {
      controller.activeStep = 1;
    });
    positionStream =
        Geolocator.getPositionStream().listen((Position? position) {
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });
    getLatAndLong(); // Initialize currentCameraPosition when the widget is created.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagePropertyControllerImp>(
      init: ManagePropertyControllerImp(),
      builder: (ManagePropertyControllerImp controller) {
        return Scaffold(
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
            title: const Text(
              "Property Location",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.all(15),
            child: Form(
              key: controller.formKey1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.easyStepper(),
                  Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: Image.asset("assets/images/logo.png", scale: 10)),
                  Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: const Text(
                      "First, let's add your property",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                    ),
                  ),
                  Container(height: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 12),
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
                    margin: const EdgeInsets.only(left: 12),
                    child: TextFormField(
                      controller: controller.streetAddress,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.map),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 12),
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

                  // Google Map
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(border: Border.all()),
                    height: 300,
                    child: Visibility(
                      visible: true,
                      child: currentCameraPosition == null
                          ? Container(
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator())
                          : Expanded(
                              child: GoogleMap(
                                markers: marker,
                                onTap: (latlng) async {
                                  marker.add(Marker(
                                    markerId: const MarkerId("9"),
                                    position: latlng,
                                  ));
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
                                      setState(() {});
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
                                initialCameraPosition: jerusalem,
                                onMapCreated: (mapcontroller) {
                                  getLatAndLong();
                                  controller.mapController1 = mapcontroller;
                                },
                              ),
                            ),
                    ),
                  ),
                  Container(height: 5),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 12),
                    child: MaterialButton(
                      minWidth: 400,
                      onPressed: arePlacemarksAvailable
                          ? () {
                              setState(() {
                                controller.increaseActiveStep();
                                print(controller.activeStep);
                              });
                              controller.userId =
                                  loginController.userDto?["id"];
                              Get.to(() => AddPropertyNeighbour());
                              // Get.to(() => AddProperty2());
                            }
                          : () {},
                      color: arePlacemarksAvailable
                          ? const Color(0xffd92328)
                          : const Color.fromARGB(255, 251, 169, 169),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
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
