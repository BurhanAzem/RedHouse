import 'dart:convert';
import 'package:client/core/class/statusrequest.dart';
import 'package:client/core/functions/checkinternet.dart';
import 'package:client/link_api.dart';
import 'package:client/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class OfferData {
  static createOffer(
    int landlordId,
    int customerId,
    int propertyId,
    String price,
    String description,
    String offerStatus,
    DateTime offerExpireDate,
    DateTime offerDate,
  ) async {
    String formattedOfferExpireDate =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(offerExpireDate);
    String formattedOfferDate =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(offerDate);

    var data = {
      "landlordId": landlordId,
      "customerId": customerId,
      "propertyId": propertyId,
      "offerDate": formattedOfferDate,
      "offerExpires": formattedOfferExpireDate,
      "description": description,
      "price": int.tryParse(price) ?? 0,
      "offerStatus": "Pending"
    };
    if (await checkInternet()) {
      var response = await http.post(Uri.parse(AppLink.offers),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $getToken()()'
          },
          body: json.encode(data),
          encoding: Encoding.getByName("utf-8"));
      print(response);
      return (response);

      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   Map responsebody = json.decode(response.body);
      //   print(responsebody);
      //   return (responsebody);
      // } else {
      //   return (StatusRequest.serverfailure);
      // }
    } else {
      return (StatusRequest.offlinefailure);
    }
  }

  static getAllOffersForUser(
      int userId, String offerStatus, String offerTo) async {
    final Map<String, dynamic> filters = {
      "offerStatus": offerStatus,
      "offerTo": offerTo,
    };

    if (await checkInternet()) {
      final Uri uri =
          Uri.https("10.0.2.2:7042", "/users/$userId/offers", filters);

      var response = await http.get(uri, headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getToken()}',
      });

      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = json.decode(response.body);
        print(responsebody["listDto"]);

        return (responsebody);
      } else {
        return StatusRequest.serverfailure;
      }
    } else {
      return StatusRequest.offlinefailure;
    }
  }

  static acceptOffer(int offerId) async {
    if (await checkInternet()) {
      var response = await http.post(Uri.parse('${AppLink.offers}/$offerId/accept'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${getToken()}',
          });
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = json.decode(response.body);
        return (responsebody);
      } else {
        return StatusRequest.serverfailure;
      }
    } else {
      return StatusRequest.offlinefailure;
    }
  }

    static deleteOffer(int id) async {
    if (await checkInternet()) {
      var response = await http.delete(Uri.parse('${AppLink.offers}/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${getToken()}',
          });
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = json.decode(response.body);
        return (responsebody);
      } else {
        return StatusRequest.serverfailure;
      }
    } else {
      return StatusRequest.offlinefailure;
    }
  }
}
