import 'dart:convert';

import 'package:client/controller/contracts/contracts_controller.dart';
import 'package:client/controller/contracts/offer_controller.dart';
import 'package:client/main.dart';
import 'package:client/model/user.dart';
import 'package:client/routes.dart';
import 'package:client/view/contracts/contract.dart';
import 'package:client/view/offers/create_offer.dart';
import 'package:client/view/offers/offer_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AllOffers extends StatefulWidget {
  const AllOffers({Key? key});

  @override
  _AllOffersState createState() => _AllOffersState();
}

class _AllOffersState extends State<AllOffers>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true; // Add a boolean variable for loading state

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  void loadData() async {
    OfferControllerImp controller =
        Get.put(OfferControllerImp(), permanent: true);
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
    // loadData();
    OfferControllerImp controller = Get.put(OfferControllerImp());
    super.build(context);
    const offerStatus = [
      "All",
      "Pending offers",
      "Accepted offers",
      "Rejected offers",
    ];

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(), // Show a loading indicator
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(CreateOffer());
          },
          shape: const CircleBorder(),
          backgroundColor: const Color.fromARGB(255, 32, 32, 32),
          child: const Icon(
            Icons.add,
            size: 25,
            color: Colors.white,
          ),
        ),
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 11),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DropdownButton<String>(
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
                // Wrap the DropdownButton with Expanded to make it take full width
                isExpanded: true,
              ),
            ),
            Container(
              height: 12,
            ),
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
                            controller.offerToSelect = "Landlord";
                          });
                          loadData();
                        } else {
                          setState(() {
                            controller.offerToSelect = "Customer";
                          });
                          loadData();
                        }
                      },
                      tabs: const [
                        Tab(text: 'Landlord Offers'),
                        Tab(text: 'Customer Offers'),
                      ],
                      overlayColor: MaterialStatePropertyAll(Colors.grey[350]),
                      indicatorColor: Colors.black,
                      labelColor: Colors.black,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      unselectedLabelColor: Colors.grey[700],
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        // Content for 'Buy' tab
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.userOffers!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => OfferDetails(
                                        offer: controller.userOffers![index],
                                      ));
                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: ListTile(
                                    title: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          decoration: const BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Icon(
                                                FontAwesomeIcons.chessKing,
                                                size: 25,
                                                color: Colors.white,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 30),
                                                child: const Text(
                                                  "Offer",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                (controller.userOffers![index]
                                                            .offerDate!
                                                            .toString()
                                                            .length <=
                                                        10)
                                                    ? "       ${controller.userOffers![index].offerDate!.toString()!}"
                                                    : "       ${controller.userOffers![index].offerDate!.toString().substring(0, 9)}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          (controller.userOffers![index]
                                                      .description!.length <=
                                                  38)
                                              ? controller.userOffers![index]
                                                  .description!
                                              : '${controller.userOffers![index].description!.substring(0, 38)}...',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
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
                                            height: 0.5,
                                            color: const Color(0xffd92328)),
                                        Container(
                                          height: 1,
                                        ),
                                        Text(
                                          (controller.userOffers![index]
                                                      .description!.length <=
                                                  100)
                                              ? controller.userOffers![index]
                                                  .description!
                                              : '${controller.userOffers![index].description!.substring(0, 100)}...',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Container(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "Price: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  controller
                                                      .userOffers![index].price!
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: Color(0xffd92328)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Offer status: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  controller.userOffers![index]
                                                      .offerStatus!,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: Color(0xffd92328)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // Add other widgets here for displaying additional information
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // Content for 'Rent' tab
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.userOffers!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(OfferDetails(
                                      offer: controller.userOffers![index]));
                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: ListTile(
                                    title: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          decoration: const BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Icon(
                                                FontAwesomeIcons.chessKing,
                                                size: 25,
                                                color: Colors.white,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 30),
                                                child: const Text(
                                                  "Offer",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                (controller.userOffers![index]
                                                            .offerDate!
                                                            .toString()
                                                            .length <=
                                                        10)
                                                    ? "       ${controller.userOffers![index].offerDate!.toString()!}"
                                                    : "       ${controller.userOffers![index].offerDate!.toString().substring(0, 9)}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          (controller.userOffers![index]
                                                      .description!.length <=
                                                  38)
                                              ? controller.userOffers![index]
                                                  .description!
                                              : '${controller.userOffers![index].description!.substring(0, 38)}...',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
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
                                            height: 0.5,
                                            color: const Color(0xffd92328)),
                                        Container(
                                          height: 1,
                                        ),
                                        Text(
                                          (controller.userOffers![index]
                                                      .description!.length <=
                                                  100)
                                              ? controller.userOffers![index]
                                                  .description!
                                              : '${controller.userOffers![index].description!.substring(0, 100)}...',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Container(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "Price: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  controller
                                                      .userOffers![index].price!
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: Color(0xffd92328)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Contract status: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  controller.userOffers![index]
                                                      .offerStatus!,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: Color(0xffd92328)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // Add other widgets here for displaying additional information
                                  ),
                                ),
                              );
                            },
                          ),
                        )
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
}
