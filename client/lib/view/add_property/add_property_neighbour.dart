import 'dart:async';
import 'package:client/controller/auth/login_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:client/controller/manage_propertise/manage_property_controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddPropertyNeighbour extends StatefulWidget {
  AddPropertyNeighbour({Key? key}) : super(key: key);

  @override
  _AddPropertyNeighbourState createState() => _AddPropertyNeighbourState();
}

class _AddPropertyNeighbourState extends State<AddPropertyNeighbour> {
  String neighbourType = "Select neighbours type";
  // bool arePlacemarksAvailable = false;

  final geocoding = GeocodingPlatform.instance;

  late double lat;
  late double long;
  Position? cl;
  CameraPosition? currentCameraPosition;
  StreamSubscription<Position>? positionStream;

  // Empty markers
  Set<Marker> markers = {};

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

  LoginControllerImp loginController = Get.put(LoginControllerImp());

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

  @override
  Widget build(BuildContext context) {
    const options = [
      "Select neighbours type",
      "Parking",
      "Mosque",
      "University",
      "School"
    ];

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
              "Neighbor Locations",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Body
          body: Container(
            margin: const EdgeInsets.all(15),
            child: Form(
              key: controller.formKey2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.easyStepper(),
                  // Container(
                  //   margin: const EdgeInsets.only(left: 12),
                  //   child: Image.asset("assets/images/logo.png", scale: 10),
                  // ),
                  Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: const Text(
                      "Add neighbors to this property",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 21),
                    ),
                  ),
                  Container(height: 20),

                  // Dropdown Button
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButton<String>(
                      value: neighbourType,
                      items: options.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            neighbourType = newValue;
                          });
                        }
                      },
                      isExpanded: true,
                      underline: const SizedBox(),
                    ),
                  ),

                  Container(height: 10),
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
                  Container(height: 5),

                  // Googel Map
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
                                markers: markers,
                                onTap: (latlng) async {
                                  print(neighbourType);
                                  if (neighbourType == "Parking") {
                                    markers.add(
                                      Marker(
                                        markerId: const MarkerId("1"),
                                        position: latlng,
                                        icon: BitmapDescriptor
                                            .defaultMarkerWithHue(
                                                BitmapDescriptor.hueViolet),
                                        infoWindow:
                                            const InfoWindow(title: 'Parking'),
                                      ),
                                    );
                                  } else if (neighbourType == "Mosque") {
                                    markers.add(
                                      Marker(
                                        markerId: const MarkerId("2"),
                                        position: latlng,
                                        icon: BitmapDescriptor
                                            .defaultMarkerWithHue(
                                                BitmapDescriptor.hueYellow),
                                        infoWindow:
                                            const InfoWindow(title: 'Mosque'),
                                      ),
                                    );
                                  } else if (neighbourType == "University") {
                                    markers.add(
                                      Marker(
                                        markerId: const MarkerId("3"),
                                        position: latlng,
                                        icon: BitmapDescriptor
                                            .defaultMarkerWithHue(
                                                BitmapDescriptor.hueBlue),
                                        infoWindow: const InfoWindow(
                                            title: 'University'),
                                      ),
                                    );
                                  } else if (neighbourType == "School") {
                                    markers.add(
                                      Marker(
                                        markerId: const MarkerId("4"),
                                        position: latlng,
                                        icon: BitmapDescriptor
                                            .defaultMarkerWithHue(
                                                BitmapDescriptor.hueGreen),
                                        infoWindow:
                                            const InfoWindow(title: 'School'),
                                      ),
                                    );
                                  }

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
                                      setState(() {});
                                    }
                                  } catch (e) {
                                    Get.defaultDialog(
                                        title: "ُEntered invalid location",
                                        middleText: 'Error: $e');
                                  }
                                  setState(() {});
                                },
                                mapType: MapType.normal,
                                initialCameraPosition: jerusalem,
                                onMapCreated: (mapcontroller) {
                                  getLatAndLong();
                                  controller.mapController2 = mapcontroller;
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
                      onPressed: () {
                        setState(() {
                          controller.increaseActiveStep();
                          print(controller.activeStep);
                        });
                        controller.userId = loginController.userDto?["id"];
                        controller.goToAddProperty2();
                      },
                      color: const Color(0xffd92328),
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


