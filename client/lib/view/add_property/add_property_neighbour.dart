import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/model/neighborhood.dart';
import 'package:client/view/add_property/add_property_2.dart';
import 'package:geocoding/geocoding.dart';
import 'package:client/controller/manage_propertise/manage_properties_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddPropertyNeighbour extends StatefulWidget {
  AddPropertyNeighbour({Key? key}) : super(key: key);

  @override
  _AddPropertyNeighbourState createState() => _AddPropertyNeighbourState();
}

class _AddPropertyNeighbourState extends State<AddPropertyNeighbour> {
  String neighbourType = "Select Neighbours Type";

  LoginControllerImp loginController = Get.put(LoginControllerImp());

  Neighborhood neighborhood = Neighborhood(
    id: 0,
    propertyId: 0,
    // property: null,
    neighborhoodType: '',
    locationId: 0,
    // location: null,
  );
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  // Give icon for each neighborhood
  void addCustomerIcon() {
    if (neighbourType == "Parking") {
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(), "assets/images/parking.png")
          .then(
        (icon) {
          setState(() {
            markerIcon = icon;
          });
        },
      );
    } else if (neighbourType == "School") {
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(), "assets/images/school.png")
          .then(
        (icon) {
          setState(() {
            markerIcon = icon;
          });
        },
      );
    } else if (neighbourType == "Hospital") {
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(), "assets/images/hospital.png")
          .then(
        (icon) {
          setState(() {
            markerIcon = icon;
          });
        },
      );
    } else if (neighbourType == "Mosque") {
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(), "assets/images/mosque.png")
          .then(
        (icon) {
          setState(() {
            markerIcon = icon;
          });
        },
      );
    } else if (neighbourType == "Gymnasium") {
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(), "assets/images/gym.png")
          .then(
        (icon) {
          setState(() {
            markerIcon = icon;
          });
        },
      );
    } else if (neighbourType == "Gas Station") {
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(), "assets/images/gas-station.png")
          .then(
        (icon) {
          setState(() {
            markerIcon = icon;
          });
        },
      );
    } else if (neighbourType == "ATM") {
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(), "assets/images/atm.png")
          .then(
        (icon) {
          setState(() {
            markerIcon = icon;
          });
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const options = [
      "Select Neighbours Type",
      "Parking",
      "School",
      "Hospital",
      "Mosque",
      "Gymnasium",
      "Gas Station",
      "ATM",
    ];

    return GetBuilder<ManagePropertiesController>(
      init: ManagePropertiesController(),
      builder: (ManagePropertiesController controller) {
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
              "Neighbours Locations",
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
                      "Add neighbours to this property",
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
                            addCustomerIcon();
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
                      child: controller.currentPosition == null
                          ? Container(
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator())
                          : Expanded(
                              child: GoogleMap(
                                markers: controller.markers,
                                onTap: (latlng) async {
                                  print(neighbourType);
                                  if (neighbourType !=
                                      "Select Neighbours Type") {
                                    controller.markers.add(
                                      Marker(
                                        markerId: MarkerId(neighbourType),
                                        position: latlng,
                                        infoWindow:
                                            InfoWindow(title: neighbourType),
                                        icon: markerIcon,
                                      ),
                                    );

                                    neighborhood!.id = 0;

                                    // controller.propertyNeighborhoods.insert(neighbourType, element);

                                    try {
                                      List<Placemark> placemarks =
                                          await placemarkFromCoordinates(
                                              latlng.latitude,
                                              latlng.longitude);

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
                                        print(
                                            'Latitude: ${controller.Latitude}');
                                        print(
                                            'Longitude: ${controller.Longitude}');
                                        setState(() {});
                                      }
                                    } catch (e) {}
                                  }
                                  setState(() {});
                                },
                                mapType: MapType.normal,
                                initialCameraPosition:
                                    controller.currentPosition!,
                                onMapCreated: (mapcontroller) {
                                  // getLatAndLong();
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
                        Get.to(() => AddProperty2());
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
