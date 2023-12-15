<<<<<<<< HEAD:client/lib/view/manage_properties/sent_application.dart
import 'dart:convert';
import 'package:client/controller/applications/applications_controller.dart';
import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/main.dart';
import 'package:client/model/application.dart';
import 'package:client/model/user.dart';
import 'package:client/view/home_information/check_account.dart';
import 'package:client/view/home_information/home_information.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SentApplication extends StatefulWidget {
  const SentApplication({super.key});

  @override
  _SentApplicationState createState() => _SentApplicationState();
}

class _SentApplicationState extends State<SentApplication> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  late Application application;
  ApplicationsController controller = Get.put(ApplicationsController());
  LoginControllerImp loginController = Get.put(LoginControllerImp());
  bool isLoading = true; // Add a boolean variable for loading state
========
// import 'dart:convert';

// import 'package:client/controller/applications/applications_controller.dart';
// import 'package:client/controller/users_auth/login_controller.dart';
// import 'package:client/main.dart';
// import 'package:client/model/application.dart';
// import 'package:client/model/user.dart';
// import 'package:client/view/home_information/check_account.dart';
// import 'package:client/view/home_information/home_information.dart';
// import 'package:client/view/offers/create_offer.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';

// class ApplicationDetails extends StatefulWidget {
//   const ApplicationDetails({super.key});

//   @override
//   _StepperDemoState createState() => _StepperDemoState();
// }

// class _StepperDemoState extends State<ApplicationDetails> {
//   int _currentStep = 0;
//   StepperType stepperType = StepperType.vertical;
//   late Application application;
//   ApplicationsController controller = Get.put(ApplicationsController());
//   LoginControllerImp loginController = Get.put(LoginControllerImp());
//   bool isLoading = true; // Add a boolean variable for loading state
>>>>>>>> 617bbd39e0c39bec3a6756db2c0634de2c1793f3:client/lib/view/manage_properties/application.dart

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//     setState(() {});
//   }

<<<<<<<< HEAD:client/lib/view/manage_properties/sent_application.dart
  void loadDataAllapliactions() async {
    ApplicationsController controller =
        Get.put(ApplicationsController(), permanent: true);
    String? userDtoJson = sharepref.getString("user");
    Map<String, dynamic> userDto = json.decode(userDtoJson ?? "{}");
    User user = User.fromJson(userDto);
    await controller.getApplications(user.id!);
========
//   void loadDataAllapliactions() async {
//     ApplicationsController controller =
//         Get.put(ApplicationsController(), permanent: true);
//     String? userDtoJson = sharepref.getString("user");
//     Map<String, dynamic> userDto = json.decode(userDtoJson ?? "{}");
//     User user = User.fromJson(userDto);
//     await controller.getApplications(user.id!);
>>>>>>>> 617bbd39e0c39bec3a6756db2c0634de2c1793f3:client/lib/view/manage_properties/application.dart

//     setState(() {
//       isLoading = false; // Set isLoading to false when data is loaded
//     });
//   }

//   void loadData() async {
//     application = Get.arguments as Application;

//     setState(() {
//       isLoading = false; // Set isLoading to false when data is loaded
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Center(
//         child: CircularProgressIndicator(), // Show a loading indicator
//       );
//     }

<<<<<<<< HEAD:client/lib/view/manage_properties/sent_application.dart
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
                  (application.applicationDate.toString().length <= 10)
                      ? "       ${application.applicationDate.toString()}"
                      : "       ${application.applicationDate.toString().substring(0, 9)}",
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
                padding: EdgeInsets.all(10),
                child: Text(
                  application.message ?? "No message available",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Container(height: 25),
            InkWell(
              onTap: () {
                Get.to(() => HomeInformation(property: application.property));
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

            // If this appliaction have offer, show "See Offer"
            if (true) seeOffer(),
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
    );
  }
}
========
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: Container(
//         height: 40,
//         child: FloatingActionButton.extended(
//           backgroundColor: Colors.black,
//           foregroundColor: Colors.white,
//           onPressed: () {
//             // Get.to(
//             //   () => CreateOffer(
//             //     // This user ID is the ID of who received the application
//             //     landlordId: application.property.userId,
//             //     // The user ID is the ID of the person who sent the application
//             //     customerId: application.userId,
//             //     propertyId: application.propertyId,
//             //   ),
//             // );
//           },
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           icon: const Icon(
//             Icons.add,
//             size: 22,
//           ),
//           label: const Text("Create offer"),
//         ),
//       ),

//       // App bar
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text(
//           "Application Details",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),

//       // Body
//       body: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
//         child: Column(
//           children: [
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Icon(
//                   FontAwesomeIcons.circleDot,
//                   size: 25,
//                   color: Color(0xffd92328),
//                 ),
//                 Text(
//                   (application.applicationDate.toString().length <= 10)
//                       ? "       ${application.applicationDate.toString()}"
//                       : "       ${application.applicationDate.toString().substring(0, 9)}",
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w600, fontSize: 12),
//                 ),
//               ],
//             ),
//             Text(
//               (application.user.name!.length <= 38)
//                   ? application.user.name!
//                   : '${application.user.name!.substring(0, 38)}...',
//               style: const TextStyle(fontWeight: FontWeight.w600),
//             ),
//             Container(
//               height: 10,
//             ),
//             Container(
//               height: 80,
//               width: 80,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: Colors.black,
//                   width: 1,
//                 ),
//               ),
//               child: const Icon(
//                 FontAwesomeIcons.solidFileZipper,
//                 size: 35,
//                 color: const Color(0xffd92328),
//               ),
//             ),
//             Container(
//               height: 10,
//             ),
//             Container(
//               height: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     const Text(
//                       "Status: ",
//                       style:
//                           TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//                     ),
//                     Text(
//                       application.applicationStatus.toString(),
//                       style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 12,
//                           color: Color(0xffd92328)),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     const Text(
//                       "Property Code: ",
//                       style:
//                           TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//                     ),
//                     Text(
//                       application.property.propertyCode,
//                       style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 14,
//                           color: Color(0xffd92328)),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Container(height: 15),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 //  Row(
//                 //   children: [
//                 //     Text(
//                 //       "Type: ",
//                 //       style:
//                 //           TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//                 //     ),
//                 //     Text(
//                 //     application.,
//                 //       style: TextStyle(
//                 //           fontWeight: FontWeight.w600,
//                 //           fontSize: 12,
//                 //           color: Color(0xffd92328)),
//                 //     ),
//                 //   ],
//                 // ),
//                 Row(
//                   children: [
//                     const Text(
//                       "Suggested price: ",
//                       style:
//                           TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//                     ),
//                     Text(
//                       "${application.suggestedPrice != 0 ? application.suggestedPrice!.toInt() : "NO suggested Price"}",
//                       style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 14,
//                           color: Color(0xffd92328)),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Container(height: 12),
//             Container(
//               alignment: Alignment.topLeft,
//               child: const Text(
//                 "Meessage: ",
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//               ),
//             ),
//             Container(height: 3),
//             Container(
//               height: 250,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   width: 1, // Adjust the border width as needed
//                   color: Colors.black, // Adjust the border color
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 padding: EdgeInsets.all(8),
//                 child: Text(
//                   "Y It will scroll if it doesn't fit within the available space. Your text goes here...",
//                   style: TextStyle(fontSize: 15),
//                 ),
//               ),
//             ),
//             Container(height: 15),

//             //
//             if (application.applicationStatus == "Pending")
//               buttonsApproveIgnore(),
//             //

//             Container(height: 15),
//             InkWell(
//               onTap: () {
//                 Get.to(() => HomeInformation(property: application.property));
//               },
//               child: Container(
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(
//                       color: Colors.black,
//                       width: 1,
//                     ),
//                   ),
//                 ),
//                 child: const Text(
//                   "Click here to see property",
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Color(0xffd92328),
//                   ),
//                 ),
//               ),
//             ),
//             Container(height: 10),
//             InkWell(
//               onTap: () {
//                 Get.to(() => CheckAccount(user: application.user));
//               },
//               child: Container(
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(
//                       color: Colors.black,
//                       width: 1,
//                     ),
//                   ),
//                 ),
//                 child: const Text(
//                   "Click here to see customer history",
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Color(0xffd92328),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buttonsApproveIgnore() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Container(
//           height: 40,
//           width: 160,
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.circular(40),
//             border: Border.all(
//               color: Colors.black,
//               width: 1,
//             ),
//           ),
//           child: MaterialButton(
//             onPressed: () {
//               setState(() {
//                 application.applicationStatus = "Approved";
//                 controller.approvedApplication(application.id);
//               });
//             },
//             child: const Text(
//               "Approve",
//               style: TextStyle(fontSize: 16, color: Colors.white),
//             ),
//           ),
//         ),
//         Container(
//           height: 40,
//           width: 160,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(50),
//             border: Border.all(
//               color: Colors.black,
//               width: 1,
//             ),
//           ),
//           child: MaterialButton(
//             onPressed: () {
//               controller.deleteApplication(application.id);
//               loadDataAllapliactions();
//               setState(() {});
//               Navigator.pop(context);
//             },
//             child: const Text(
//               "Ignore",
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
>>>>>>>> 617bbd39e0c39bec3a6756db2c0634de2c1793f3:client/lib/view/manage_properties/application.dart
