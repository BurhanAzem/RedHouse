import 'package:client/controller/applications/applications_controller.dart';
import 'package:client/link_api.dart';
import 'package:client/model/application.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ApplicationDetails extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<ApplicationDetails> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    ApplicationsControllerImp controller = Get.put(ApplicationsControllerImp());
    Application application = Get.arguments as Application;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Payments timeline'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
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
                    (application.user!.Name!.length <= 38)
                        ? application.user!.Name!
                        : '${application.user!.Name!.substring(0, 38)}...',
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
                    onPressed: () {
                      Get.toNamed(AppRoute.userHistory);
                    },
                    child: Text(
                      "Click here to check user history",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffd92328),
                        decoration: TextDecoration
                            .underline, // Add underline decoration
                      ),
                    ),
                  ),
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
                  )
                ],
              ),
              // Add other widgets here for displaying additional information
            ),
          ],
        ),
      ),
    );
  }
}
