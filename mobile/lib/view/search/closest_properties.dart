import 'dart:async';
import 'package:client/controller/bottom_bar/filter_controller.dart';
import 'package:client/controller/map_list/map_list_controller.dart';
import 'package:client/controller/propertise/properties_controller.dart';
import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/model/property.dart';
import 'package:client/view/bottom_bar/bottom_bar.dart';
import 'package:client/view/home_information/home_information.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class ClosestProperties extends StatefulWidget {
  const ClosestProperties({Key? key}) : super(key: key);

  @override
  _ClosestPropertiesState createState() => _ClosestPropertiesState();
}

class _ClosestPropertiesState extends State<ClosestProperties>
    with SingleTickerProviderStateMixin {
  ManagePropertiesController propertiesController =
      Get.put(ManagePropertiesController());
  FilterController filterController = Get.put(FilterController());
  LoginControllerImp loginController = Get.put(LoginControllerImp());
  MapListController mapListController = Get.find<MapListController>();
  PageController _pageController = PageController();

  CameraPosition? currentPosition;
  MapType currentMapType = MapType.normal;
  GoogleMapController? mapController;
  late bool _isLoading;
  late Timer _timer;

  late BitmapDescriptor icon;

  @override
  void initState() {
    loadClosestProperties();
    setState(() {
      _isLoading = true;
    });

    _timer = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });

    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> loadClosestProperties() async {
    icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/current-location.png",
    );

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng centerCoordinates = LatLng(position.latitude, position.longitude);

    setState(() {
      currentPosition = CameraPosition(
        target: centerCoordinates,
        zoom: 14,
      );
    });

    await propertiesController.getClosestProperties(
      currentPosition!.target.latitude,
      currentPosition!.target.longitude,
    );
    print(propertiesController.closestProperties);

    propertiesController.allMarkers = propertiesController.closestProperties
        .map((property) => Marker(
              markerId: MarkerId(property.id.toString()),
              position: LatLng(
                property.location?.latitude ?? 0.0,
                property.location?.longitude ?? 0.0,
              ),
              icon: property.userId == loginController.userDto?["id"]
                  ? BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueViolet)
                  : filterController.listingType
                      ? BitmapDescriptor.defaultMarker
                      : BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueBlue),
              onTap: () {
                Get.to(() => HomeInformation(property: property));
              },
            ))
        .toSet();

    propertiesController.allMarkers.add(
      Marker(
        markerId: const MarkerId('site_location'),
        position: centerCoordinates,
        icon: icon,
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              Get.to(() => const BottomBar());
            });
          },
        ),
        title: const Text(
          "Closest Properties",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          if (currentPosition != null)
            SizedBox(
              height: 300,
              child: GoogleMap(
                mapType: currentMapType,
                initialCameraPosition: currentPosition!,
                onMapCreated: (controller) {
                  mapController = controller;
                },
                myLocationButtonEnabled: true,
                markers: propertiesController.allMarkers,
              ),
            )
          else
            Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.grey[400],
                  backgroundColor: Colors.grey[200],
                ),
              ),
            ),

          if (currentPosition != null)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: propertiesController.closestProperties.length,
                itemBuilder: (context, index) {
                  final Property property =
                      propertiesController.closestProperties.elementAt(index);

                  // Check if property with the same ID exists in favoriteProperties
                  bool isFavorite = mapListController.favoriteProperties
                      .any((favProperty) => favProperty.id == property.id);

                  return PropertyWidget(property: property);
                },
              ),
            ),
        ],
      ),
    );
  }
}

class PropertyWidget extends StatelessWidget {
  final Property property;

  const PropertyWidget({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => HomeInformation(property: property));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 35, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          color: Color.fromARGB(255, 196, 39, 27),
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
                        fontWeight: FontWeight.bold, fontSize: 18),
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
                            color: Color.fromARGB(255, 196, 39, 27),
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
                          text: '${property.numberOfBathRooms} ',
                          style: const TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 196, 39, 27),
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
                            color: Color.fromARGB(255, 196, 39, 27),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 170,
                            child: Text(
                              property.location!.streetAddress,
                              style: const TextStyle(fontSize: 14.5),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 1),
                          SizedBox(
                            width: 170,
                            child: Text(
                              "${property.location!.city}, ${property.location!.country}",
                              style: const TextStyle(fontSize: 14.5),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 180,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: const BorderSide(
                                color: Colors.black, width: 1.4),
                          ),
                          onPressed: () {
                            Get.to(() => HomeInformation(property: property));
                          },
                          height: 37,
                          child: const Center(
                            child: Text(
                              "Check availability",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.5,
                                fontWeight: FontWeight.bold,
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
          ],
        ),
      ),
    );
  }
}
