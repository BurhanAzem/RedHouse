// import 'dart:convert';
// import 'package:client/core/class/statusrequest.dart';
// import 'package:client/core/functions/checkinternet.dart';
// import 'package:client/link_api.dart';
// import 'package:client/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class NeighborhoodData {
//   static addNeighborhoods(
//     int propertyId,
//     String neighborhoodType,
//     String neighborhoodName,
//     String streetAddress,
//     String city,
//     String region,
//     String postalCode,
//     String country,
//     dynamic latitude,
//     dynamic longitude,
//   ) async {
//     var data = {
//       "propertyId": propertyId,
//       "neighborhoodType": neighborhoodType,
//       "neighborhoodName": neighborhoodName,
//       "locationDto": {
//         "streetAddress": streetAddress,
//         "city": city,
//         "region": region,
//         "postalCode": postalCode,
//         "country": country,
//         "latitude": latitude,
//         "longitude": longitude
//       },
//     };
//     if (await checkInternet()) {
//       var response = await http.post(Uri.parse(AppLink.neighborhoods),
//           headers: <String, String>{
//             'Content-Type': 'application/json',
//             'Authorization': 'Bearer $getToken()()'
//           },
//           body: json.encode(data),
//           encoding: Encoding.getByName("utf-8"));
//       print(response.statusCode);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Map responsebody = json.decode(response.body);
//         print(responsebody);
//         return (responsebody);
//       } else {
//         return (StatusRequest.serverfailure);
//       }
//     } else {
//       return (StatusRequest.offlinefailure);
//     }
//   }
// }
