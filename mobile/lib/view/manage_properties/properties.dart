import 'dart:async';
import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/controller/manage_propertise/manage_properties_controller.dart';
import 'package:client/view/add_property/add_property_1.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:client/model/property.dart';
import 'package:client/view/home_information/home_information.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Properties extends StatefulWidget {
  const Properties({Key? key}) : super(key: key);

  @override
  _AllPropertiesState createState() => _AllPropertiesState();
}

const propertiesFilterList = [
  "Rented properties",
  "Purchased properties",
  "Posted properties",
  "All properties"
];

class _AllPropertiesState extends State<Properties>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true; // Add a boolean variable for loading data from api
  ManagePropertiesController controller = Get.put(ManagePropertiesController());
  LoginControllerImp loginController = Get.put(LoginControllerImp());

  late bool _isLoading; // Add a boolean variable for loading images
  Timer? _timer;

  @override
  bool get wantKeepAlive => true; // Keep the state alive

  Future<void> getLatAndLong() async {
    Position cl = await Geolocator.getCurrentPosition().then((value) => value);
    double lat = cl.latitude;
    double long = cl.longitude;
    controller.currentPosition =
        CameraPosition(target: LatLng(lat, long), zoom: 13);
  }

  @override
  void initState() {
    super.initState();
    loadData();
    getLatAndLong();
    setState(() {});
  }

  void loadData() async {
    controller.propertiesUserId = loginController.userDto?["id"];
    await controller.getPropertiesUser();

    setState(() {
      isLoading = false; // Set isLoading to false when data is loaded
    });

    _isLoading = true;
    _timer = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      );
    }

    return VisibilityDetector(
      key: const Key('UserProperties'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 1) {
          loadData(); // Call your initialization logic here
        }
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: controller.userProperties.isEmpty
            ? null
            : SizedBox(
                height: 40,
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    Get.to(() => AddProperty1());
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  icon: const Icon(
                    Icons.add,
                    size: 22,
                  ),
                  label: const Text("Add property"),
                ),
              ),

        // Body
        body: Column(
          children: [
            Container(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: 360,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DropdownButton<String>(
                alignment: Alignment.centerLeft,
                isExpanded: true,
                value: controller.propertiesFilter,
                onChanged: (String? newValue) {
                  setState(() {
                    controller.propertiesFilter = newValue!;
                    loadData();
                  });
                },
                items: propertiesFilterList.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
              ),
            ),
            Container(height: 10),

            // userProperties isEmpty
            if (controller.userProperties.isEmpty)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  SvgPicture.asset(
                    'assets/images/house_searching.svg',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Oops! No results found",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "You did not offer a property for",
                    style: TextStyle(fontSize: 17),
                  ),
                  const Text(
                    "sell or rent.",
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: 200,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        Get.to(() => AddProperty1());
                      },
                      height: 45,
                      color: Colors.black87,
                      child: const Center(
                        child: Text(
                          "Add property",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )

            // userProperties isNotEmpty
            else
              Expanded(
                child: ListView.builder(
                  itemCount: controller.userProperties.length,
                  itemBuilder: (context, index) {
                    Property property =
                        controller.userProperties.elementAt(index);
                    return InkWell(
                      onTap: () {
                        Get.to(() => HomeInformation(property: property));
                      },
                      child: Container(
                        margin: index == (controller.userProperties.length - 1)
                            ? const EdgeInsets.only(
                                top: 25, bottom: 65, left: 15, right: 15)
                            : const EdgeInsets.only(
                                top: 10, bottom: 20, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (property.propertyFiles != null &&
                                property.propertyFiles!.isNotEmpty)
                              Stack(
                                children: [
                                  if (_isLoading)
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          child: Image.network(
                                            property.propertyFiles![0]
                                                .downloadUrls!,
                                            width: double.infinity,
                                            height: 220,
                                            fit: BoxFit.cover,
                                          )),
                                    )
                                  else
                                    ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        child: Image.network(
                                          property
                                              .propertyFiles![0].downloadUrls!,
                                          width: double.infinity,
                                          height: 220,
                                          fit: BoxFit.cover,
                                        )),
                                ],
                              ),
                            Container(
                              padding: const EdgeInsets.only(left: 4, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromARGB(255, 196, 39, 27),
                                        ),
                                      ),
                                      Text(
                                        " ${property.listingType}",
                                        style: const TextStyle(fontSize: 17.5),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "\$${NumberFormat.decimalPattern().format(property.price)}${property.listingType == "For rent" ? "/mo" : ""}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    property.propertyType,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 196, 39, 27),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${property.numberOfBedRooms} ',
                                          style: const TextStyle(
                                            fontSize: 16.5,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 196, 39, 27),
                                          ),
                                        ),
                                        const TextSpan(
                                          text: 'bedrooms, ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '${property.numberOfBathRooms} ',
                                          style: const TextStyle(
                                            fontSize: 16.5,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 196, 39, 27),
                                          ),
                                        ),
                                        const TextSpan(
                                          text: 'bathrooms, ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '${property.squareMetersArea} ',
                                          style: const TextStyle(
                                            fontSize: 16.5,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 196, 39, 27),
                                          ),
                                        ),
                                        const TextSpan(
                                          text: 'meters',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 170,
                                            child: Text(
                                              property.location!.streetAddress,
                                              style: const TextStyle(
                                                  fontSize: 14.5),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(height: 1),
                                          SizedBox(
                                            width: 170,
                                            child: Text(
                                              "${property.location!.city}, ${property.location!.country}",
                                              style: const TextStyle(
                                                  fontSize: 14.5),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 180,
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            side: const BorderSide(
                                                color: Colors.black,
                                                width: 1.4),
                                          ),
                                          onPressed: () {
                                            Get.to(() => HomeInformation(
                                                property: property));
                                          },
                                          height: 37,
                                          child: const Center(
                                            child: Text(
                                              "Show details",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.5,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // To add the house to favorites
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
