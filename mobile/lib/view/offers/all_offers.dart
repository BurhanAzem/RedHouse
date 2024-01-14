import 'dart:convert';
import 'package:client/controller/contract/offer_controller.dart';
import 'package:client/main.dart';
import 'package:client/model/offer.dart';
import 'package:client/model/user.dart';
import 'package:client/view/offers/incoming_offer.dart';
import 'package:client/view/offers/sent_offer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AllOffers extends StatefulWidget {
  const AllOffers({Key? key});

  @override
  _AllOffersState createState() => _AllOffersState();
}

class _AllOffersState extends State<AllOffers>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true; // Add a boolean variable for loading state
  OfferController controller = Get.put(OfferController());

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  void loadData() async {
    OfferController controller = Get.put(OfferController(), permanent: true);
    String? userDtoJson = sharepref.getString("user");
    Map<String, dynamic> userDto = json.decode(userDtoJson ?? "{}");
    User user = User.fromJson(userDto);
    await controller.getAllOffersForUser(user.id!);

    setState(() {
      isLoading = false; // Set isLoading to false when data is loaded
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const offerStatus = [
      "All",
      "Pending",
      "Accepted",
    ];

    const offerType = [
      "All",
      "For daily rent",
      "For monthly rent",
      "For sell",
    ];

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey[200],
        ),
      );
    }
    return VisibilityDetector(
      key: const Key('widget1'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 1) {
          loadData();
        }
      },
      child: Scaffold(
        // App bar
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "All Offers",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Body
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: TextFormField(
                // Use your controller here if needed
                style: const TextStyle(height: 1.2),
                decoration: InputDecoration(
                  hintText: "Search by offer, customer, landlord name",
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

            // Filters
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 180,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButton<String>(
                    alignment: Alignment.centerLeft,
                    isExpanded: true,
                    value: controller.offerStatusSelect,
                    onChanged: (String? newValue) {
                      setState(() {
                        controller.offerStatusSelect = newValue!;
                        loadData();
                      });
                    },
                    items: offerStatus.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: 180,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButton<String>(
                    alignment: Alignment.centerLeft,
                    isExpanded: true,
                    value: controller.offerTypeSelect,
                    onChanged: (String? newValue) {
                      setState(() {
                        controller.offerTypeSelect = newValue!;
                        loadData();
                      });
                    },
                    items: offerType.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(
                          option,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Container(height: 12),
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
                            controller.offerToSelect = "Customer";
                          });
                          loadData();
                        } else {
                          setState(() {
                            controller.offerToSelect = "Landlord";
                          });
                          loadData();
                        }
                      },
                      tabs: const [
                        Tab(text: 'Incoming Offers'),
                        Tab(text: 'Sent Offers'),
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
                        // Content for 'Incoming Offers' tab
                        // contentIncomingOffers(),
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
                              return contentIncomingOffers();
                            }
                          },
                        ),

                        // Content for 'Sent Offers' tab
                        // contentSentOffers(),
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
                              return contentSentOffers();
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
      ),
    );
  }

  Widget contentIncomingOffers() {
    if (controller.userOffers.isEmpty) {
      return const Center(
        child: Text(
          "No Any Incoming Offer",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: controller.userOffers.length,
          itemBuilder: (context, index) {
            Offer offer = controller.userOffers[index];
            EdgeInsets _margin;

            if (index == controller.userOffers.length - 1) {
              _margin =
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 30);
            } else {
              _margin = const EdgeInsets.only(right: 12, left: 12, top: 30);
            }

            return GestureDetector(
              onTap: () {
                Get.to(() => IncomingOffer(offer: offer));
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: const Offset(0, 0),
                      blurRadius: 5,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                margin: _margin,
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              FontAwesomeIcons.chessKing,
                              size: 26,
                              color: Colors.white,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 50),
                              child: Text(
                                "Offer ${index + 1}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd').format(offer.offerDate),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text(
                          (offer.description.length <= 60)
                              ? offer.description
                              : '${offer.description.substring(0, 60)}...',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Divider(
                      //   thickness: 1.5,
                      //   height: 1.5,
                      //   color: Colors.red[200],
                      // ),
                      const SizedBox(height: 15),
                    ],
                  ),
                  subtitle: Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                    child: Container(
                      height: 200,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 20),
                              // Text(
                              //   "Property Code",
                              //   style: TextStyle(
                              //     color: Colors.white,
                              //     fontWeight: FontWeight.w700,
                              //     fontSize: 15,
                              //   ),
                              // ),
                              SizedBox(height: 5),
                              Text(
                                "Offer Status",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "EXP Date",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Landlord",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 25),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 25),
                              Text(
                                offer.property!.propertyCode,
                                style: TextStyle(
                                  color: Colors.red[200],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.5,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                offer.offerStatus,
                                style: TextStyle(
                                  color: Colors.red[200],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.5,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(offer.offerExpires),
                                style: TextStyle(
                                  color: Colors.red[200],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.5,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                (offer.landlord!.name!.length <= 14)
                                    ? offer.landlord!.name!
                                    : '${offer.landlord!.name!.substring(0, 14)}...',
                                style: TextStyle(
                                  color: Colors.red[200],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.5,
                                ),
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  Widget contentSentOffers() {
    if (controller.userOffers.isEmpty) {
      return const Center(
        child: Text(
          "No any Sent Offer",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: controller.userOffers.length,
          itemBuilder: (context, index) {
            Offer offer = controller.userOffers[index];
            EdgeInsets _margin;

            if (index == controller.userOffers.length - 1) {
              _margin =
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 30);
            } else {
              _margin = const EdgeInsets.only(right: 12, left: 12, top: 30);
            }

            return GestureDetector(
              onTap: () {
                Get.to(() => SentOffer(offer: offer));
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: const Offset(0, 0),
                      blurRadius: 5,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                margin: _margin,
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              FontAwesomeIcons.chessKing,
                              size: 26,
                              color: Colors.white,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 50),
                              child: Text(
                                "Offer ${index + 1}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd').format(offer.offerDate),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text(
                          (offer.description.length <= 60)
                              ? offer.description
                              : '${offer.description.substring(0, 60)}...',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Divider(
                        thickness: 1.5,
                        height: 1.5,
                        color: Colors.red[200],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  subtitle: Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                    child: Container(
                      height: 200,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 25),
                              Text(
                                "Property Code",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Offer Status",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "EXP Date",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Client",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 25),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 25),
                              Text(
                                offer.property!.propertyCode,
                                style: TextStyle(
                                  color: Colors.red[200],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.5,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                offer.offerStatus,
                                style: TextStyle(
                                  color: Colors.red[200],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.5,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(offer.offerExpires),
                                style: TextStyle(
                                  color: Colors.red[200],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.5,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                (offer.customer!.name!.length <= 14)
                                    ? offer.customer!.name!
                                    : '${offer.customer!.name!.substring(0, 14)}...',
                                style: TextStyle(
                                  color: Colors.red[200],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.5,
                                ),
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
