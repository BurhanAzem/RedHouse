import 'dart:math';
import 'package:client/controller/account_info_contoller.dart';
import 'package:client/controller/bottom_bar/filter_controller.dart';
import 'package:client/model/property.dart';
import 'package:client/view/bottom_bar/search/home%20information/account%20history/check_account.dart';
import 'package:client/view/bottom_bar/search/home%20information/action_buttons_widget.dart';
import 'package:client/view/bottom_bar/search/home%20information/image_slider_widget.dart';
import 'package:client/view/bottom_bar/search/home%20information/property%20history/check_property.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class HomeInformation extends StatefulWidget {
  final Property property;

  const HomeInformation({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  State<HomeInformation> createState() => _HomeInformationState();
}

class _HomeInformationState extends State<HomeInformation> {
  FilterController filterController = Get.put(FilterController());
  AccountInfoContoller accountController = Get.put(AccountInfoContoller());
  int ZipCode = Random().nextInt(90000) + 10000;
  GoogleMapController? mapController;
  late CameraPosition homePosition;
  List<Marker> homeMarker = [];
  int slider = 1;

  @override
  void initState() {
    super.initState();
    homePosition = CameraPosition(
      target: LatLng(
        widget.property.location.Latitude,
        widget.property.location.Longitude,
      ),
      zoom: 13,
    );

    homeMarker = [
      Marker(
        markerId: MarkerId(widget.property.Id.toString()),
        position: LatLng(
          widget.property.location.Latitude,
          widget.property.location.Longitude,
        ),
        icon: filterController.listingType
            ? BitmapDescriptor.defaultMarker
            : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                ImageSliderWidget(propertyFiles: widget.property.PropertyFiles),
                Container(
                  padding: const EdgeInsets.only(left: 25, top: 15, right: 17),
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
                            " ${widget.property.ListingType}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "\$${NumberFormat.decimalPattern().format(widget.property.Price)}${widget.property.ListingType == "For rent" ? "/mo" : ""}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'ZIP code: ',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 196, 39, 27),
                              ),
                            ),
                            TextSpan(
                              text: '$ZipCode',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${widget.property.NumberOfBedRooms} ',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 196, 39, 27),
                              ),
                            ),
                            const TextSpan(
                              text: 'bedrooms, ',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: '${widget.property.NumberOfBathRooms} ',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 196, 39, 27),
                              ),
                            ),
                            const TextSpan(
                              text: 'bathrooms',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 3),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${NumberFormat.decimalPattern().format(widget.property.squareMetersArea)} ',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 186, 36, 25),
                              ),
                            ),
                            const TextSpan(
                              text: 'meters',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Row(
                            children: [
                              const Icon(FontAwesomeIcons.hammer, size: 31),
                              const SizedBox(width: 12),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Built in ',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${widget.property.BuiltYear.year}',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 196, 39, 27),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text('Year built',
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 45),
                              const Icon(Icons.home_work, size: 35),
                              const SizedBox(width: 12),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.property.View,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 196, 39, 27),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    Text('Property view',
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          const Icon(FontAwesomeIcons.houseCircleExclamation,
                              size: 30),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${widget.property.PropertyType} ',
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 196, 39, 27),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (widget.property.NumberOfUnits != 0)
                                      const TextSpan(
                                        text: '/ ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    if (widget.property.NumberOfUnits != 0)
                                      TextSpan(
                                        text:
                                            '${widget.property.NumberOfUnits} ',
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 196, 39, 27),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    if (widget.property.NumberOfUnits != 0)
                                      const TextSpan(
                                        text: 'Units',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 196, 39, 27),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Text('Property type',
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Card(
                        elevation: 0.5,
                        color: Colors.white,
                        child: ListTile(
                          leading: const Icon(
                            Icons.location_on_sharp,
                            size: 33,
                            color: Color.fromARGB(255, 196, 39, 27),
                          ),
                          title: Text(
                            "${widget.property.location.StreetAddress}, ${widget.property.location.City}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            "${widget.property.location.Country}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // here Parking Spots
                      if (widget.property.ParkingSpots == 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "This property does not have parking",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 2),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "Are you looking for parking?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'this property has ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${widget.property.ParkingSpots}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 196, 39, 27),
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' Parking Spots',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 2),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "Are you looking for more parking?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      // here AvailableOn and PropertyStatus
                      const SizedBox(height: 22),
                      const Text(
                        "Property Status:",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 196, 39, 27),
                        ),
                      ),
                      if (widget.property.PropertyStatus == "Coming soon")
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text:
                                    " This property accepts requests and offers, but it takes some time to be available. It will be available on date  ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${DateFormat.MMMM().format(widget.property.BuiltYear)} ${DateFormat.d().format(widget.property.BuiltYear)}, ${DateFormat.y().format(widget.property.BuiltYear)}.',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 196, 39, 27),
                                ),
                              ),
                            ],
                          ),
                        )
                      else if (widget.property.PropertyStatus ==
                          "Accepting offers")
                        const Text(
                            ' This property is available, accepts requests and offers.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ))
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                    height: 230,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: homePosition,
                      onMapCreated: (controller) {
                        setState(() {
                          mapController = controller;
                        });
                      },
                      markers: homeMarker.toSet(),
                    )),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Posted by a ',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: '${widget.property.ListingBy}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 196, 39, 27),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const CheckAccount());
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 25),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[400],
                        ),
                        child: Center(
                          child: Icon(
                            FontAwesomeIcons.personCircleExclamation,
                            size: 28,
                            color: Colors.grey[100],
                          ),
                        ),
                      ),
                      const Expanded(
                          child: ListTile(
                        title: Text(
                          "Ayman Dwikat",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Click here to check history"),
                      )),
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          size: 32,
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 25),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const CheckProperty());
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 25),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[400],
                        ),
                        child: Center(
                          child: Icon(
                            FontAwesomeIcons.houseCircleExclamation,
                            size: 26,
                            color: Colors.grey[100],
                          ),
                        ),
                      ),
                      const Expanded(
                          child: ListTile(
                        title: Text(
                          "Property",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Click here to check history"),
                      )),
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          size: 32,
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 25),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 25, top: 15, right: 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Property Description:",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 196, 39, 27),
                        ),
                      ),
                      Text(
                        " ${widget.property.PropertyDescription}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (widget.property.UserId != accountController.userDto?["id"])
            ActionButtonsWidget(property: widget.property),
        ],
      ),
    );
  }
}
