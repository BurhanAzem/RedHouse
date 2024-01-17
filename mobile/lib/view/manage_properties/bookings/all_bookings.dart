import 'dart:convert';
import 'package:client/controller/application/applications_controller.dart';
import 'package:client/controller/booking/booking_controller.dart';
import 'package:client/main.dart';
import 'package:client/model/booking.dart';
import 'package:client/model/user.dart';
import 'package:client/view/card/credit_card.dart';
import 'package:client/view/card/style/card_background.dart';
import 'package:client/view/manage_properties/applications/incoming_application.dart';
import 'package:client/view/manage_properties/applications/sent_application.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AllBookings extends StatefulWidget {
  const AllBookings({Key? key});

  @override
  _AllBookingsState createState() => _AllBookingsState();
}

class _AllBookingsState extends State<AllBookings> {
  bool isLoading = true; // Add a boolean variable for loading state
  BookingController bookingController =
      Get.put(BookingController(), permanent: true);

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  void loadData() async {
    String? userDtoJson = sharepref.getString("user");
    Map<String, dynamic> userDto = json.decode(userDtoJson ?? "{}");
    User user = User.fromJson(userDto);
    await bookingController.getBookingsForUser(user.id!);

    setState(() {
      isLoading = false; // Set isLoading to false when data is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if data is still loading
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: TextFormField(
              // Use your controller here if needed
              style: const TextStyle(height: 1.2),
              decoration: InputDecoration(
                hintText: "Search by book, customer, landlord name",
                suffixIcon: const Icon(Icons.search),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              child: DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Scaffold(
                  appBar: TabBar(
                    onTap: (value) {
                      if (value == 0) {
                        setState(() {
                          bookingController.bookingTo = "Customer";
                        });
                        loadData();
                      } else {
                        setState(() {
                          bookingController.bookingTo = "LandLord";
                        });
                        loadData();
                      }
                    },
                    tabs: const [
                      Tab(text: 'My Bookings'),
                      Tab(text: 'Incoming Bookings'),
                    ],
                    overlayColor: MaterialStatePropertyAll(Colors.grey[350]),
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    unselectedLabelColor: Colors.grey[700],
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      FutureBuilder(
                        future: Future.delayed(const Duration(seconds: 1)),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.grey[200],
                              ),
                            );
                          } else {
                            return contentMyBookings();
                          }
                        },
                      ),
                      FutureBuilder(
                        future: Future.delayed(const Duration(seconds: 1)),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.grey[200],
                              ),
                            );
                          } else {
                            return contentIncomingBookings();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contentMyBookings() {
    if (bookingController.userBookings.isEmpty) {
      return const Center(
        child: Text(
          "No any sent appliaction",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    } else {
      print(bookingController.userBookings.isEmpty);
      return Expanded(
        child: ListView.builder(
          itemCount: bookingController.userBookings.length,
          itemBuilder: (context, index) {
            Booking booking = bookingController.userBookings[index];

            EdgeInsets _margin;

            if (index == bookingController.userBookings.length - 1) {
              _margin = const EdgeInsets.symmetric(vertical: 30);
            } else {
              _margin = const EdgeInsets.only(top: 30);
            }

            return GestureDetector(
              onTap: () {
                setState(() {
                  // Get.to(const SentApplication(), arguments: booking);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                margin: _margin,
                child: ListTile(
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            FontAwesomeIcons.circleDot,
                            size: 25,
                            color: const Color(0xffd92328),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd')
                                .format(booking.bookingDate),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                        ],
                      ),
                      Text(
                        (booking.property!.user!.name!.length) <= 38
                            ? booking.property!.user!.name!
                            : '${booking.property!.user!.name!.substring(0, 38)}...',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  isThreeLine:
                      true, // This allows the title to take up more horizontal space
                  subtitle: Column(
                    children: [
                      Container(
                        height: 1,
                      ),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 1, // Adjust the width as needed
                          ),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.solidFileZipper,
                          size: 25,
                          color: const Color(0xffd92328),
                        ),
                      ),
                      Container(
                        height: 1,
                      ),
                      Container(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "status: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              Text(
                                booking.bookingStatus,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: Color(0xffd92328)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Property Code: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              Text(
                                booking.property!.propertyCode,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: Color(0xffd92328)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  Widget contentIncomingBookings() {
    if (bookingController.userBookings.isEmpty) {
      return const Center(
        child: Text(
          "No any incoming appliaction",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: bookingController.userBookings.length,
          itemBuilder: (context, index) {
            Booking booking = bookingController.userBookings[index];

            EdgeInsets _margin;

            if (index == bookingController.userBookings.length - 1) {
              _margin = const EdgeInsets.symmetric(vertical: 30);
            } else {
              _margin = const EdgeInsets.only(top: 30);
            }

            return GestureDetector(
              onTap: () {
                setState(() {
                  // Get.to(const IncomingApplication(), arguments: booking);
                });
              },
              child: Container(
                margin: _margin,
                child: CreditCard(
                  type: "booking",
                  booking: booking,
                  index: index,
                  name: booking.user!.name!,
                  showBackSide: true,
                  frontBackground: CardBackgrounds.black,
                  backBackground: CardBackgrounds.white,
                  showShadow: true,
                  height: 150,
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
