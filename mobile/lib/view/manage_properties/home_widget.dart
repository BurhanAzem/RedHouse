import 'package:client/controller/booking/booking_controller.dart';
import 'package:client/controller/propertise/properties_controller.dart';
import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/controller/bottom_bar/filter_controller.dart';
import 'package:client/model/property.dart';
import 'package:client/view/home_information/check_account.dart';
import 'package:client/view/home_information/image_slider_widget.dart';
import 'package:client/view/home_information/check_property.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class HomeWidget extends StatefulWidget {
  final Property property;

  const HomeWidget({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  FilterController filterController = Get.put(FilterController());
  LoginControllerImp loginController = Get.put(LoginControllerImp());
  ManagePropertiesController controller = Get.put(ManagePropertiesController());
  BookingController bookingController = Get.put(BookingController());
  GoogleMapController? mapController;
  late CameraPosition propertyPosition;
  int slider = 1;

  late final Map<String, BitmapDescriptor> neighborhoodIcons;
  Set<Marker> propertyMarker = {};

  @override
  void initState() {
    super.initState();

    propertyPosition = CameraPosition(
      target: LatLng(
        widget.property.location!.latitude,
        widget.property.location!.longitude,
      ),
      zoom: 13,
    );

    propertyMarker.add(
      Marker(
        markerId: MarkerId(widget.property.id.toString()),
        position: LatLng(
          widget.property.location!.latitude,
          widget.property.location!.longitude,
        ),
        icon: widget.property.listingType == "For sell"
            ? BitmapDescriptor.defaultMarker
            : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );

    // Initialize the neighborhoodIcons map asynchronously
    initNeighborhoodIcons().then((icons) {
      setState(() {
        neighborhoodIcons = icons;
      });
      loadData();
    });
  }

  void loadData() async {
    await controller.getNeighborhoodsForProperty(widget.property.id);
    print(controller.propertyNeighborhoods);

    await bookingController.getBookingDaysForProperty(widget.property.id);
    print(bookingController.preBookedDays);

    // Now you can use neighborhoodIcons in your loop
    for (var neighborhood in controller.propertyNeighborhoods) {
      BitmapDescriptor? icon = neighborhoodIcons[neighborhood.neighborhoodType];
      if (icon != null) {
        propertyMarker.add(
          Marker(
            markerId: MarkerId(neighborhood.neighborhoodType),
            position: LatLng(
              neighborhood.location.latitude!,
              neighborhood.location.longitude!,
            ),
            icon: icon,
            infoWindow: InfoWindow(title: neighborhood.neighborhoodType),
          ),
        );
      }
    }
    setState(() {});
  }

  Future<Map<String, BitmapDescriptor>> initNeighborhoodIcons() async {
    return {
      "Parking": await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        "assets/images/parking.png",
      ),
      "School": await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        "assets/images/school.png",
      ),
      "Hospital": await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        "assets/images/hospital.png",
      ),
      "Mosque": await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        "assets/images/mosque.png",
      ),
      "Gymnasium": await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        "assets/images/gym.png",
      ),
      "Gas Station": await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        "assets/images/gas-station.png",
      ),
      "ATM": await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        "assets/images/atm.png",
      ),
    };
  }

  Future<void> _showAvailableDates() async {
    DateTime currentDate = DateTime.now();
    DateTime tomorrow =
        DateTime(currentDate.year, currentDate.month, currentDate.day + 1);
    DateTime lastDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day + 32);

    DateTime? firstAvailableDate = findFirstAvailableDate(tomorrow, lastDate);

    if (firstAvailableDate == null) {
      // No available date found, show dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData(
              dialogBackgroundColor: Colors.white,
            ),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "All days are booked",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        "All days from tomorrow through the month are booked",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ButtonBar(children: [
                      SizedBox(
                        height: 40,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "Close",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17.5,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          );
        },
      );
      return;
    }

    await showDatePicker(
      context: context,
      initialDate: firstAvailableDate,
      firstDate: tomorrow,
      lastDate: lastDate,
      selectableDayPredicate: (DateTime date) {
        // Prevent selection of dates in the bookingdays list
        if (bookingController.preBookedDays.contains(date)) {
          return false; // Date is booked, not selectable
        }

        return true; // Date is available and not in the bookingdays list, selectable
      },
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(),
          child: child ?? Container(),
        );
      },
    );
  }

  DateTime? findFirstAvailableDate(DateTime start, DateTime end) {
    DateTime currentDate = start;
    while (currentDate.isBefore(end)) {
      if (!bookingController.preBookedDays.contains(currentDate)) {
        return currentDate;
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }
    return null; // No available date found
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
                if (widget.property.propertyFiles != null &&
                    widget.property.propertyFiles!.isNotEmpty)
                  ImageSliderWidget(
                    propertyFiles: widget.property.propertyFiles!,
                    property: widget.property,
                  ),
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
                            " ${widget.property.listingType}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "\$${NumberFormat.decimalPattern().format(widget.property.price)}${widget.property.listingType == "For rent" ? "/mo" : ""}",
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
                              text: widget.property.propertyCode,
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
                              text: '${widget.property.numberOfBedRooms}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 196, 39, 27),
                              ),
                            ),
                            const TextSpan(
                              text: ' bedrooms, ',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: '${widget.property.numberOfBathRooms}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 196, 39, 27),
                              ),
                            ),
                            const TextSpan(
                              text: ' bathrooms',
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
                                fontSize: 20,
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
                                                '${widget.property.builtYear.year}',
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
                                    Text(widget.property.view,
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
                                      text: '${widget.property.propertyType} ',
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 196, 39, 27),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (widget.property.numberOfUnits != 0)
                                      const TextSpan(
                                        text: '/ ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    if (widget.property.numberOfUnits != 0)
                                      TextSpan(
                                        text:
                                            '${widget.property.numberOfUnits} ',
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 196, 39, 27),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    if (widget.property.numberOfUnits != 0)
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
                            "${widget.property.location?.streetAddress}, ${widget.property.location?.city}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            "${widget.property.location?.country}",
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
                      if (widget.property.parkingSpots == 0)
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
                                    text: '${widget.property.parkingSpots}',
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
                      if (widget.property.propertyStatus == "Coming soon")
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
                                    '${DateFormat.MMMM().format(widget.property.builtYear)} ${DateFormat.d().format(widget.property.builtYear)}, ${DateFormat.y().format(widget.property.builtYear)}.',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 196, 39, 27),
                                ),
                              ),
                            ],
                          ),
                        )
                      else if (widget.property.propertyStatus ==
                          "Accepting offers")
                        const Text(
                            ' This property is available, accepts requests and offers.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )),

                      // When is it available ?
                      if (widget.property.listingType == "For daily rent")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.9),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: InkWell(
                                onTap: _showAvailableDates,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "When is it available ?",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    IconButton(
                                      onPressed: _showAvailableDates,
                                      icon:
                                          const Icon(Icons.date_range_outlined),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),

                // Googel map
                const SizedBox(height: 30),
                SizedBox(
                    height: 230,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: propertyPosition,
                      onMapCreated: (controller) {
                        setState(() {
                          mapController = controller;
                        });
                      },
                      markers: propertyMarker,
                    )),

                // Ckeck history
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
                          text: widget.property.listingBy,
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
                    Get.to(() => CheckAccount(user: widget.property.user!));
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
                      Expanded(
                          child: ListTile(
                        title: Text(
                          widget.property.user?.name ?? 'DefaultName',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text("Click here to see history"),
                      )),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => CheckProperty(property: widget.property));
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
                        subtitle: Text("Click here to see history"),
                      )),
                    ],
                  ),
                ),
                Container(
                  padding:
                      widget.property.userId != loginController.userDto?["id"]
                          ? const EdgeInsets.only(
                              left: 25, right: 20, top: 15, bottom: 17)
                          : const EdgeInsets.only(
                              left: 25, right: 20, top: 15, bottom: 30),
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
                        " ${widget.property.propertyDescription}",
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
        ],
      ),
    );
  }
}
