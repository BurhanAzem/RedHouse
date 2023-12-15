// import 'package:client/data/neighborhood.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class NeighborhoodController extends GetxController {
//   List<Neighborhoods> propertyNeighborhoods = [];

//   int propertyId = 0;
//   String neighborhoodType = "";
//   String? neighborhoodName;

//   // For location
//   TextEditingController? streetAddress;
//   String? city;
//   String? region;
//   String? postalCode;
//   String? country;
//   double latitude = 0;
//   double longitude = 0;

//   void addNeighborhood(Neighborhoods neighborhood) {
//     propertyNeighborhoods.add(neighborhood);
//   }

//   AddNeighborhoods() async {
//     var response = await NeighborhoodData.addNeighborhoods(
//       propertyId,
//       neighborhoodType,
//       neighborhoodName!,
//       streetAddress!.text,
//       city!,
//       region!,
//       postalCode!,
//       country!,
//       latitude,
//       longitude,
//     );

//     if (response['statusCode'] == 200) {
//       print(response['listDto']);
//     } else {
//       Get.defaultDialog(
//         title: "Error",
//         middleText:
//             "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
//       );
//     }
//   }
// }


// class Neighborhoods {
//   int propertyId;
//   String neighborhoodType;
//   String? neighborhoodName;

//   // For location
//   String? streetAddress;
//   String? city;
//   String? region;
//   String? postalCode;
//   String? country;
//   double latitude;
//   double longitude;

//   // Constructor
//   Neighborhoods({
//     required this.propertyId,
//     required this.neighborhoodType,
//     this.neighborhoodName,
//     this.streetAddress,
//     this.city,
//     this.region,
//     this.postalCode,
//     this.country,
//     required this.latitude,
//     required this.longitude,
//   });
// }
