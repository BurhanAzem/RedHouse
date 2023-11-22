// import 'package:client/controller/manage_propertise/manage_property_controller.dart';
// import 'package:client/view/bottom_bar/bottom_bar.dart';
// import 'package:client/view/manage_properties/properties.dart';
// import 'package:easy_stepper/easy_stepper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AddProperty9 extends StatefulWidget {
//   AddProperty9({Key? key}) : super(key: key);

//   @override
//   _AddProperty9State createState() => _AddProperty9State();
// }

// class _AddProperty9State extends State<AddProperty9> {
//   // final PageController pageController;
//   @override
//   Widget build(BuildContext context) {
//     const options = [
//       "House",
//       "Apartment Unit",
//       "Castel",
//       "Townhouse",
//       "Entire Department Community"
//     ];
//     ManagePropertyControllerImp controller =
//         Get.put(ManagePropertyControllerImp(), permanent: true);
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             // Perform your action here
//             // For example, you can navigate back
//             setState(() {
//               controller.activeStep--;
//               Navigator.pop(context);
//             });
//           },
//         ),
//         title: const Row(
//           children: [
//             Text(
//               "Red",
//               style: TextStyle(
//                 color: Color(0xffd92328),
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               "House Manage Properties",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           child: ListView(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   controller.easyStepper(),
//                   Image.asset("assets/images/logo.png", scale: 10),
//                   Container(height: 5),
//                   const Text(
//                     "Let's start creating your property",
//                     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
//                   ),
//                   Container(height: 20),
//                   const Text(
//                     "Square meter",
//                     style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   Container(height: 5),
//                   TextFormField(
//                     controller: controller.squareMeter,
//                     style: const TextStyle(),
//                     decoration: InputDecoration(
//                       suffixIcon: const Icon(Icons.square_foot),
//                       floatingLabelBehavior: FloatingLabelBehavior.always,
//                       contentPadding: const EdgeInsets.all(5),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   Container(height: 25),
//                   const Text(
//                     "Total bedrooms",
//                     style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   TextFormField(
//                     controller: controller.numberOfUnits,
//                     style: const TextStyle(height: 0.8),
//                     decoration: InputDecoration(
//                       hintText: "",
//                       suffixIcon: const Icon(Icons.numbers),
//                       floatingLabelBehavior: FloatingLabelBehavior.always,
//                       contentPadding: const EdgeInsets.all(5),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   Container(height: 25),
//                   const Text(
//                     "Total bathrooms",
//                     style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   TextFormField(
//                     controller: controller.numberOfUnits,
//                     style: const TextStyle(height: 0.8),
//                     decoration: InputDecoration(
//                       hintText: "",
//                       suffixIcon: const Icon(Icons.numbers),
//                       floatingLabelBehavior: FloatingLabelBehavior.always,
//                       contentPadding: const EdgeInsets.all(5),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   Container(height: 5),
//                   Container(
//                       alignment: Alignment.center,
//                       child:
//                           Image.asset("assets/images/red-tree.png", scale: 3)),
//                 ],
//               ),
//               Container(height: 25),
//               MaterialButton(
//                 onPressed: () {
//                   // controller.AddProperty();
//                   // Get.to(() => const BottomBar());
//                   Get.offAll(() => const BottomBar());
//                 },
//                 color: const Color(0xffd92328),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Text(
//                   "Save property",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               Container(height: 15),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
