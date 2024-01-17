import 'dart:convert';
import 'package:client/controller/contract/offer_controller.dart';
import 'package:client/main.dart';
import 'package:client/model/offer.dart';
import 'package:client/model/user.dart';
import 'package:client/view/card/credit_card.dart';
import 'package:client/view/offers/incoming_offer.dart';
import 'package:client/view/card/style/card_background.dart';
import 'package:flutter/material.dart';
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
              _margin = const EdgeInsets.symmetric(vertical: 30);
            } else {
              _margin = const EdgeInsets.only(top: 30);
            }

            return GestureDetector(
              onTap: () {
                Get.to(() => IncomingOffer(offer: offer));
                setState(() {});
              },
              child: Container(
                margin: _margin,
                child: CreditCard(
                  type: "offer",
                  offer: offer,
                  index: index,
                  name: offer.landlord!.name!,
                  showBackSide: true,
                  frontBackground: CardBackgrounds.black,
                  backBackground: CardBackgrounds.white,
                  showShadow: true,
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
              _margin = const EdgeInsets.symmetric(vertical: 30);
            } else {
              _margin = const EdgeInsets.only(top: 30);
            }

            return GestureDetector(
              onTap: () {
                Get.to(() => IncomingOffer(offer: offer));
                setState(() {});
              },
              child: Container(
                margin: _margin,
                child: CreditCard(
                  type: "offer",
                  offer: offer,
                  index: index,
                  name: offer.customer!.name!,
                  showBackSide: true,
                  frontBackground: CardBackgrounds.black,
                  backBackground: CardBackgrounds.white,
                  showShadow: true,
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
