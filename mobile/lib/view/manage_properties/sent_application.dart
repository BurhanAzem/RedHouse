import 'dart:convert';
import 'package:client/controller/applications/applications_controller.dart';
import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/main.dart';
import 'package:client/model/application.dart';
import 'package:client/model/user.dart';
import 'package:client/view/home_information/check_account.dart';
import 'package:client/view/home_information/create_booking.dart';
import 'package:client/view/home_information/home_information.dart';
import 'package:client/view/manage_properties/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SentApplication extends StatefulWidget {
  const SentApplication({super.key});

  @override
  _SentApplicationState createState() => _SentApplicationState();
}

class _SentApplicationState extends State<SentApplication>
    with TickerProviderStateMixin {
  StepperType stepperType = StepperType.vertical;
  late Application application;
  ApplicationsController controller = Get.put(ApplicationsController());
  LoginControllerImp loginController = Get.put(LoginControllerImp());
  bool isLoading = true; // Add a boolean variable for loading state

  late AnimationController _vibrateController;
  late Animation<double> _vibrateAnimation;

  @override
  void initState() {
    super.initState();
    _vibrateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _vibrateAnimation = Tween(begin: 4.0, end: -4.0).animate(
      CurvedAnimation(
        parent: _vibrateController,
        curve: Curves.easeInOut,
      ),
    );
    loadData();
    setState(() {});
  }

  void loadDataAllapliactions() async {
    ApplicationsController controller =
        Get.put(ApplicationsController(), permanent: true);
    String? userDtoJson = sharepref.getString("user");
    Map<String, dynamic> userDto = json.decode(userDtoJson ?? "{}");
    User user = User.fromJson(userDto);
    await controller.getApplications(user.id!);

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
            fontSize: 19,
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
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Text(
              (application.property.user!.name!.length) <= 38
                  ? application.property.user!.name!
                  : '${application.property.user!.name!.substring(0, 38)}...',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
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
                      "${application.suggestedPrice != 0 ? application.suggestedPrice!.toInt() : "No suggested Price"}",
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
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            Container(height: 3),
            Container(
              height: 250,
              width: 800,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1, // Adjust the border width as needed
                  color: Colors.black, // Adjust the border color
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(10),
                child: Text(
                  application.message ?? "No message available",
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
            Container(height: 25),
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
                Get.to(() => CheckAccount(user: application.property.user!));
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
                  "Click here to see landlord history",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffd92328),
                  ),
                ),
              ),
            ),
            Container(height: 20),

            // createBooking or seeOffer
            if (application.property.listingType == "For daily rent")
              createBooking()
            else
              seeOffer(),
          ],
        ),
      ),
    );
  }

  Widget seeOffer() {
    return Container(
      // width: 300,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          // If this appliaction have offer, show "See Offer"
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
            SizedBox(width: 8),
            Text("See Offer"),
          ],
        ),
      ),
    );
  }

  Widget createBooking() {
    return AnimatedBuilder(
      animation: _vibrateAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_vibrateAnimation.value, 0.0),
          child: Container(
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                if (application.applicationStatus == "Approved") {
                  Get.to(() => CreateBooking(property: application.property));
                } else {
                  // Start the vibrating animation
                  _vibrateController.forward(from: 0.0);
                }
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
                    FontAwesomeIcons.add,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text("Create Booking"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
