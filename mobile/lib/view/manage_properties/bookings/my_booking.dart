import 'package:client/controller/application/applications_controller.dart';
import 'package:client/controller/booking/booking_controller.dart';
import 'package:client/controller/contract/offer_controller.dart';
import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/model/booking.dart';
import 'package:client/model/bookingDay.dart';
import 'package:client/view/home_information/booking_code.dart';
import 'package:client/view/home_information/check_account.dart';
import 'package:client/view/manage_properties/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  _MyBookingState createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> with TickerProviderStateMixin {
  late Booking booking;
  BookingController bookingController = Get.put(BookingController());
  ApplicationsController controller = Get.put(ApplicationsController());
  LoginControllerImp loginController = Get.put(LoginControllerImp());
  OfferController offerController = Get.put(OfferController());
  Color primaryColor = const Color.fromARGB(255, 80, 77, 77);

  String divideCodeIntoGroups(String code) {
    final RegExp pattern = RegExp(r".{1,3}");
    Iterable<Match> matches = pattern.allMatches(code);
    List<String> groups = matches.map((match) => match.group(0)!).toList();
    return groups.join(" ");
  }

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  void loadData() async {
    booking = Get.arguments as Booking;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 240, 240),

      // App bar
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: primaryColor,
      ),

      // Body
      body: ListView(
        children: [
          Container(
            height: 160,
            decoration:  BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
              color: primaryColor,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 25,
                  left: 0,
                  child: Container(
                    height: 77,
                    width: 275,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      color: Color.fromARGB(255, 243, 240, 240),
                    ),
                    child:  Center(
                      child: Text(
                        "Your Booking               ",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 80,
            color:  primaryColor,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                ),
                color: Color.fromARGB(255, 243, 240, 240),
              ),
            ),
          ),

          // // // //
          Container(
            height: 230,
            child: Stack(
              children: [
                Positioned(
                  top: 35,
                  left: 20,
                  child: Material(
                    child: Container(
                      height: 180,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 238, 238),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 87, 86, 86)
                                .withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 4,
                            offset: const Offset(-10, 10),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 30,
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          booking.bookingStatus,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Color.fromARGB(255, 244, 242, 242),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 60,
                    left: 195,
                    child: Container(
                      height: 150,
                      width: 170,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('yyyy-MM-dd')
                                .format(booking.bookingDate),
                            style:  TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            (booking.property!.user!.name!.length <= 15)
                                ? booking.property!.user!.name!
                                : '${booking.property!.user!.name!.substring(0, 15)}...',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const Divider(color: Colors.grey),
                          Text(
                            divideCodeIntoGroups(
                                booking.property!.propertyCode),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),

          // Container with variable height
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 35, bottom: 35),
                constraints: BoxConstraints(
                  minHeight: 100,
                  maxHeight: constraints.maxHeight,
                ),
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                  color: primaryColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.bookingDays!.length == 1
                            ? "Booking Day"
                            : "Booking Days",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...booking.bookingDays!.map<Widget>((BookingDay days) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              DateFormat('MMM dd', 'en_US')
                                  .format(days.dayDate),
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                              maxLines: null,
                            ),
                            IconButton(
                              icon: const Icon(
                                FontAwesomeIcons.check,
                                color: Colors.white,
                                size: 22,
                              ),
                              onPressed: () {
                                setState(() {});
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              );
            },
          ),

          // // // //
          Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => HomeWidget(property: booking.property!));
                },
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Click here to see property",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 23, 77, 138),
                    ),
                  ),
                ),
              ),
              Container(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => CheckAccount(user: booking.property!.user!));
                },
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Click here to see landlord history",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 23, 77, 138),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(height: 30),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Show "See Code"
                seeCode(),
              ],
            ),
          ),

          Container(height: 25),
        ],
      ),
    );
  }

  Widget seeCode() {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () async {
          Get.to(() => BookingCode(bookingCode: booking.bookingCode));
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.eye,
              size: 18,
            ),
            SizedBox(width: 10),
            Text("See Code"),
          ],
        ),
      ),
    );
  }
}
