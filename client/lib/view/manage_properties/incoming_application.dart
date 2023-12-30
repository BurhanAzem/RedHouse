import 'dart:convert';
import 'package:client/controller/applications/applications_controller.dart';
import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/main.dart';
import 'package:client/model/application.dart';
import 'package:client/model/user.dart';
import 'package:client/view/home_information/check_account.dart';
import 'package:client/view/home_information/home_information.dart';
import 'package:client/view/manage_properties/home_widget.dart';
import 'package:client/view/offers/create_offer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class IncomingApplication extends StatefulWidget {
  const IncomingApplication({super.key});

  @override
  _IncomingApplicationState createState() => _IncomingApplicationState();
}

class _IncomingApplicationState extends State<IncomingApplication> {
  StepperType stepperType = StepperType.vertical;

  late Application application;
  ApplicationsController controller = Get.put(ApplicationsController());
  LoginControllerImp loginController = Get.put(LoginControllerImp());

  bool isLoading = true; // Add a boolean variable for loading state

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  void loadAllApplications() async {
    await controller.getApplications(loginController.userDto?["id"]);

    setState(() {
      isLoading = false; // Set isLoading to false when data is loaded
    });
  }

  void loadData() async {
    application = Get.arguments as Application;

    setState(() {
      isLoading = false; // Set isLoading to false when data is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      );
    }

    return Scaffold(
      // App bar
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Application Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Body
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  FontAwesomeIcons.circleDot,
                  size: 25,
                  color: Color(0xffd92328),
                ),
                Text(
                  DateFormat('yyyy-MM-dd').format(application.applicationDate),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ],
            ),
            Text(
              (application.user.name!.length <= 38)
                  ? application.user.name!
                  : '${application.user.name!.substring(0, 38)}...',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
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
                  width: 1,
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
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Text(
                      application.applicationStatus.toString(),
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
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Text(
                      application.property.propertyCode,
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
                      "Suggested price: ",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Text(
                      "${application.suggestedPrice != 0 ? application.suggestedPrice!.toInt() : "NO suggested Price"}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xffd92328)),
                    ),
                  ],
                ),
              ],
            ),
            Container(height: 12),
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                "Meessage: ",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
            Container(height: 3),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1, // Adjust the border width as needed
                  color: Colors.black, // Adjust the border color
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(8),
                child: Text(
                  "Y It will scroll if it doesn't fit within the available space. Your text goes here...",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),

            // Two links see
            Container(height: 15),
            InkWell(
              onTap: () {
                Get.to(() => HomeWidget(property: application.property));
              },
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
                child: const Text(
                  "Click here to see property",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffd92328),
                  ),
                ),
              ),
            ),
            Container(height: 10),
            InkWell(
              onTap: () {
                Get.to(() => CheckAccount(user: application.user));
              },
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
                child: const Text(
                  "Click here to see customer history",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffd92328),
                  ),
                ),
              ),
            ),
            Container(height: 20),

            // Show "Approve" and "Ignore"
            if (application.applicationStatus == "Pending")
              approveIgnoreButtons(),

            // Show "Create Offer" and/or "See Offer"
            if (application.applicationStatus == "Approved") offerButtons(),
          ],
        ),
      ),
    );
  }

  Widget approveIgnoreButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 40,
          width: 160,
          child: ElevatedButton(
            onPressed: () {
              controller.approvedApplication(application.id);
              loadAllApplications();
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text("Approve"),
          ),
        ),
        Container(
          height: 40,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: ElevatedButton(
            onPressed: () {
              controller.deleteApplication(application.id);
              loadAllApplications();
              setState(() {});
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text("Ignore"),
          ),
        ),
      ],
    );
  }

  Widget offerButtons() {
    if (true) {
      return Column(
        children: [
          createOffer(),
          SizedBox(height: 10),
          Container(
            height: 40,
            child: ElevatedButton(
              onPressed: () {},
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
                  SizedBox(width: 8),
                  Text("See Offer"),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
        // width: 300,
        child: createOffer(),
      );
    }
  }

  Widget createOffer() {
    return Container(
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          Get.to(
            () => CreateOffer(
              // This user ID is the ID of who received the application
              landlordId: application.property.userId,
              // The user ID is the ID of the person who sent the application
              customerId: application.userId,
              propertyId: application.propertyId,
              property: application.property,
            ),
          );
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
              Icons.add,
              size: 18,
            ),
            SizedBox(width: 8),
            Text("Create Offer"),
          ],
        ),
      ),
    );
  }
}
