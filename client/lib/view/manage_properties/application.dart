import 'dart:convert';

import 'package:client/controller/applications/applications_controller.dart';
import 'package:client/link_api.dart';
import 'package:client/main.dart';
import 'package:client/model/application.dart';
import 'package:client/model/property.dart';
import 'package:client/model/user.dart';
import 'package:client/routes.dart';
import 'package:client/view/bottom_bar/search/home%20information/home_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ApplicationDetails extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<ApplicationDetails> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  late Application application;
  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  void loadData() async {
    ApplicationsControllerImp controller =
        Get.put(ApplicationsControllerImp(), permanent: true);
    application = Get.arguments as Application;

    await controller.getHistoryUser(application.userId);
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    ApplicationsControllerImp controller = Get.put(ApplicationsControllerImp());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Application Details'),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
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
                      // Image.asset("assets/images/application_icon.jpg",
                      //     scale: 18),

                      Text(
                        (application.applicationDate!.toString().length <= 10)
                            ? "       ${application.applicationDate!.toString()!}"
                            : "       ${application.applicationDate!.toString().substring(0, 9)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ],
                  ),
                  Text(
                    (application.user!.name!.length <= 38)
                        ? application.user!.name!
                        : '${application.user!.name!.substring(0, 38)}...',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              isThreeLine:
                  true, // This allows the title to take up more horizontal space
              subtitle: Column(
                children: [
                  Container(
                    height: 10,
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 1, // Adjust the width as needed
                      ),
                    ),
                    child: const Icon(
                      FontAwesomeIcons.solidFileZipper,
                      size: 35,
                      color: const Color(0xffd92328),
                    ),
                  ),

                  Container(
                    height: 10,
                  ),
                  // Text(
                  //   (controller.applications![index].Message!.length <=
                  //           50)
                  //       ? controller.applications![index].Message!
                  //       : '${controller.applications![index].Message!
                  //               .substring(0, 50)}...',
                  //   style: const TextStyle(fontWeight: FontWeight.w400),
                  // ),
                  Container(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Status: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          Text(
                            application.applicationStatus!.toString(),
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
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          Text(
                            application.property.propertyCode!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(0xffd92328)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Type: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          Text(
                            application.applicationType,
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
                            "Suggested price: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          Text(
                            application.property.listingType + "   ",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(0xffd92328)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(height: 10),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Meessage: ",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                  Container(height: 3),
                  Container(
                    // margin: EdgeInsets.all(14),
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1, // Adjust the border width as needed
                        color: Colors.black, // Adjust the border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Y It will scroll if it doesn't fit within the available space. Your text goes here...",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  Container(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 40,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(
                              40), // Set a large border radius
                          border: Border.all(
                            color: Colors
                                .black, // Adjust the border color as needed
                            width: 1, // Adjust the border width as needed
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            "Approve",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              50), // Set a large border radius
                          border: Border.all(
                            color: Colors
                                .black, // Adjust the border color as needed
                            width: 1, // Adjust the border width as needed
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            "Reject",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 6),

                  MaterialButton(
                    onPressed: () {},
                    child: Text(
                      "Click here to see property",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffd92328),
                        decoration: TextDecoration
                            .underline, // Add underline decoration
                      ),
                    ),
                  ),
                ],
              ),
              // Add other widgets here for displaying additional information
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.userHistory.length,
              itemBuilder: (context, index) {
                return GestureDetector(
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
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              FontAwesomeIcons.businessTime,
                              size: 25,
                              color: const Color(0xffd92328),
                            ),
                            InkWell(
                              onTap: () {
                                Property property = controller.userHistory![index]
                                        .contract!.property!;
                                Get.to(() => HomeInformation(
                                    property: property));
                              },
                              child: Text(
                                controller.userHistory[index].contract.property!
                                    .propertyCode,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xffd92328),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  (controller.userHistory![index].contract
                                              .startDate!
                                              .toString()
                                              .length <=
                                          10)
                                      ? "       ${controller.userHistory![index].contract.startDate!.toString()!}"
                                      : "       ${controller.userHistory![index].contract.startDate!.toString().substring(0, 9)} ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                                Text("-"),
                                Text(
                                  (controller.userHistory![index].contract
                                              .startDate!
                                              .toString()
                                              .length <=
                                          10)
                                      ? " ${controller.userHistory![index].contract.endDate!.toString()!}"
                                      : " ${controller.userHistory![index].contract.endDate!.toString().substring(0, 9)}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "To ${controller.userHistory![index].contract.customer!.name!}: ",
                              style: TextStyle(fontSize: 11),
                            ),
                            RatingBar.builder(
                              initialRating: controller
                                  .userHistory![index].customerRating
                                  .toDouble(),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 0.2),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Color(0xffd92328),
                                size: 10,
                              ),
                              itemSize: 20,
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "    ${controller.userHistory![index].feedbackToCustomer!}",
                            style: TextStyle(fontSize: 14),
                            softWrap:
                                true, // This will make text wrap to a new line when it overflows.
                          ),
                        ),

                        Row(
                          children: [
                            Text(
                              "To landlord ${controller.userHistory![index].contract.landlord!.name}: ",
                              style: TextStyle(fontSize: 11),
                            ),
                            RatingBar.builder(
                              initialRating: controller
                                  .userHistory![index].landlordRating
                                  .toDouble(),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 0.2),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Color(0xffd92328),
                                size: 10,
                              ),
                              itemSize: 15,
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "    ${controller.userHistory![index].feedbackToLandlord!}",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            softWrap:
                                true, // This will make text wrap to a new line when it overflows.
                          ),
                        ),
                        // Add other widgets here for displaying additional information
                      ]),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
