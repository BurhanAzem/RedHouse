// import 'package:client/model/offer.dart';
// import 'package:flutter/material.dart';

// class OfferDetails extends StatefulWidget {
//   final Offer offer;
//   const OfferDetails({Key? key, required this.offer}) : super(key: key);
//   @override
//   _StepperDemoState createState() => _StepperDemoState();
// }

// class _StepperDemoState extends State<OfferDetails> {
//   int _currentStep = 0;
//   StepperType stepperType = StepperType.vertical;
//   bool showMoreSummary = false;
//   String summaryString = "Show more";

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text(
//           "Offer Details",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.all(15),
//           child: Column(
//             children: [
//               Container(height: 20),

//               // Box Informations
//               Container(
//                 padding: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 1,
//                       blurRadius: 0,
//                       offset: const Offset(0, 0),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.symmetric(vertical: 15),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text("Landlord:",
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600)),
//                               Text(widget.offer.landlord!.name!,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 196, 39, 27))),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.symmetric(vertical: 15),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                   child: const Text(
//                                 "Offer Status",
//                                 style: TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.w600),
//                               )),
//                               Container(
//                                   child: Text(widget.offer.offerStatus,
//                                       style: const TextStyle(
//                                           color: Color.fromARGB(
//                                               255, 196, 39, 27))))
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.symmetric(vertical: 15),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                   child: const Text("Price",
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600))),
//                               Text(widget.offer.price.toString(),
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 196, 39, 27)))
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       // margin: const EdgeInsets.only(bottom: 78),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.symmetric(vertical: 15),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   child: const Text("Client:",
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                       )),
//                                 ),
//                                 Container(
//                                     child: Text(
//                                   widget.offer.customer!.name!,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 196, 39, 27)),
//                                 )),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.symmetric(vertical: 15),
//                             child: Column(
//                               children: [
//                                 Container(
//                                     child: const Text("Start date",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600))),
//                                 Text(
//                                     widget.offer.offerDate
//                                         .toString()
//                                         .substring(0, 11),
//                                     style: const TextStyle(
//                                         color:
//                                             Color.fromARGB(255, 196, 39, 27))),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.symmetric(vertical: 15),
//                             child: Column(
//                               children: [
//                                 Container(
//                                     child: const Text("Expiry date",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600))),
//                                 Text(
//                                     widget.offer.offerExpireDate
//                                         .toString()
//                                         .substring(0, 11),
//                                     style: const TextStyle(
//                                         color:
//                                             Color.fromARGB(255, 196, 39, 27))),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Container(height: 20),

//               // Box description
//               Container(
//                 padding: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 1,
//                       blurRadius: 0,
//                       offset: const Offset(0, 0),
//                     ),
//                   ],
//                 ),
//                 child: Column(children: [
//                   Container(
//                       alignment: Alignment.topLeft,
//                       child: const Text(
//                         "Description",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w500),
//                       )),
//                   Container(
//                     height: 15,
//                   ),
//                   Text(widget.offer.description),
//                   Container(
//                     height: 5,
//                   ),
//                   showMoreSummary
//                       ? Column(
//                           children: [
//                             Container(
//                               height: 5,
//                             ),
//                           ],
//                         )
//                       : Container(),
//                   MaterialButton(
//                     onPressed: () {
//                       setState(() {
//                         showMoreSummary = !showMoreSummary;
//                       });
//                     },
//                     child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 15, vertical: 5),
//                         decoration: BoxDecoration(
//                             border: Border.all(width: 1),
//                             borderRadius: BorderRadius.circular(15)),
//                         child: Text(
//                           !showMoreSummary ? "Show more" : "Show less",
//                           style: const TextStyle(fontWeight: FontWeight.w600),
//                         )),
//                   )
//                 ]),
//               ),
//               Container(height: 35),

//               //
//               if (widget.offer.offerStatus == "Pending") acceptRejectButtons(),
//               //
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget acceptRejectButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Container(
//           height: 40,
//           width: 160,
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius:
//                 BorderRadius.circular(40), // Set a large border radius
//             border: Border.all(
//               color: Colors.black, // Adjust the border color as needed
//               width: 1, // Adjust the border width as needed
//             ),
//           ),
//           child: MaterialButton(
//             onPressed: () {},
//             child: const Text(
//               "Accept",
//               style: TextStyle(fontSize: 16, color: Colors.white),
//             ),
//           ),
//         ),
//         Container(
//           height: 40,
//           width: 160,
//           decoration: BoxDecoration(
//             borderRadius:
//                 BorderRadius.circular(50), // Set a large border radius
//             border: Border.all(
//               color: Colors.black, // Adjust the border color as needed
//               width: 1, // Adjust the border width as needed
//             ),
//           ),
//           child: MaterialButton(
//             onPressed: () {},
//             child: const Text(
//               "Reject",
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
