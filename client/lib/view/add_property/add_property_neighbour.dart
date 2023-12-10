import 'package:client/controller/manage_propertise/neighborhood_controller.dart';
import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/view/add_property/add_property_2.dart';
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
  String neighborhoodType = "Select Neighborhood Type";

  LoginControllerImp loginController = Get.put(LoginControllerImp());
  NeighborhoodController neighborhoodController =
      Get.put(NeighborhoodController());

  ManagePropertiesController propertyController =
      Get.put(ManagePropertiesController());

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  // Give icon for each neighborhood
  void addCustomerIcon() {
    if (neighborhoodType == "Parking") {
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(), "assets/images/parking.png")
          .then(
        (icon) {
          setState(() {
            markerIcon = icon;
          });
        },
      );
    } else if (neighborhoodType == "School") {
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(), "assets/images/school.png")
          .then(
        (icon) {
          setState(() {
            markerIcon = icon;
          });
        },
      );
    } else if (neighborhoodType == "Hospital") {
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(), "assets/images/hospital.png")
          .then(
        (icon) {
          setState(() {
            markerIcon = icon;
          });
        },
      );
    } else if (neighborhoodType == "Mosque") {
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(), "assets/images/mosque.png")
          .then(
        (icon) {
          setState(() {
            markerIcon = icon;
          });
        },
      );
    } else if (neighborhoodType == "Gymnasium") {
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(), "assets/images/gym.png")
          .then(
        (icon) {
          setState(() {
            markerIcon = icon;
          });
        },
      );
    } else if (neighborhoodType == "Gas Station") {
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(), "assets/images/gas-station.png")
          .then(
        (icon) {
          setState(() {
            markerIcon = icon;
          });
        },
      );
    } else if (neighborhoodType == "ATM") {
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
    print(propertyController.markers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const options = [
      "Select Neighborhood Type",
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
              "Neighborhoods Locations",
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
                      value: neighborhoodType,
                      items: options.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            neighborhoodType = newValue;
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
                              child: const CircularProgressIndicator(),
                            )
                          : Expanded(
                              child: GoogleMap(
                                markers: controller.markers,
                                onTap: (latlng) async {
                                  print(controller.markers);
                                  print(neighborhoodType);

                                  if (neighborhoodType !=
                                      "Select Neighborhood Type") {
                                    // Remove the marker with the specified ID
                                    controller.markers.removeWhere(
                                      (marker) =>
                                          marker.markerId.value ==
                                          neighborhoodType,
                                    );

                                    // Add a new marker
                                    controller.markers.add(
                                      Marker(
                                        markerId: MarkerId(neighborhoodType),
                                        position: latlng,
                                        infoWindow:
                                            InfoWindow(title: neighborhoodType),
                                        icon: markerIcon,
                                      ),
                                    );

                                    setState(() {});
                                  }
                                },
                                mapType: MapType.normal,
                                initialCameraPosition:
                                    controller.currentPosition!,
                                onMapCreated: (mapcontroller) {
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
