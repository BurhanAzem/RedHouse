import 'dart:convert';
import 'package:client/core/class/statusrequest.dart';
import 'package:client/core/functions/checkinternet.dart';
import 'package:client/link_api.dart';
import 'package:client/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class PropertyData {
  static postdata(
      String propertyType,
      String price,
      String numberOfBedrooms,
      String numberOfBathrooms,
      String squareMeter,
      String propertyDescription,
      DateTime builtYear,
      String view,
      DateTime availableOn,
      String propertyStatus,
      String numberOfUnits,
      String parkingSpots,
      String listingType,
      String isAvailableBasement,
      String listingBy,
      int userId,
      List<String> downloadUrls,
      String streetAddress,
      String city,
      String region,
      String postalCode,
      String country,
      dynamic latitude,
      dynamic longitude) async {
    String formattedBuiltYear =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(builtYear);
    String formattedAvailableOn =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(availableOn);

    var data = {
      "propertyType": propertyType,
      "userId": userId,
      "price": int.tryParse(price) ?? 0,
      "availableOn": formattedAvailableOn,
      "numberOfBedrooms": int.tryParse(numberOfBedrooms) ?? 0,
      "numberOfBathrooms": int.tryParse(numberOfBathrooms) ?? 0,
      "squareMeter": int.tryParse(squareMeter) ?? 0,
      "propertyDescription": propertyDescription,
      "builtYear": formattedBuiltYear,
      "view": view,
      "propertyStatus": propertyStatus,
      "numberOfUnits": int.tryParse(numberOfUnits) ?? 0,
      "parkingSpots": int.tryParse(parkingSpots) ?? 0,
      "listingType": listingType,
      "isAvailableBasement": isAvailableBasement,
      "listingBy": listingBy,
      "locationDto": {
        "streetAddress": streetAddress,
        "city": city,
        "region": region,
        "postalCode": postalCode,
        "country": country,
        "latitude": latitude,
        "longitude": longitude
      },
      // "neighborhoodDto":{},
      "propertyFiles": downloadUrls
    };
    if (await checkInternet()) {
      var response = await http.post(Uri.parse(AppLink.properties),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $getToken()()'
          },
          body: json.encode(data),
          encoding: Encoding.getByName("utf-8"));
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = json.decode(response.body);
        print(responsebody);
        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
    // return response.fold((l) => l, (r) => r);
  }

  static getdata(
      List<String> propertyTypes,
      String minPrice,
      String maxPrice,
      String numberOfBathrooms,
      String numberOfBedrooms,
      String view,
      String listingType,
      String listingBy) async {
    final String propertyTypesParam = jsonEncode(propertyTypes);
    final Map<String, String> filters = {
      "propertyType": propertyTypesParam,
      "minPrice": minPrice,
      "maxPrice": maxPrice,
      "numberOfBedrooms": numberOfBedrooms,
      "numberOfBathrooms": numberOfBathrooms,
      "view": view,
      "listingType": listingType,
      "listingBy": listingBy,
    };

    if (await checkInternet()) {
      final uri = Uri.https("", AppLink.properties, filters);

      var response = await http.get(uri, headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getToken()}'
      });
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = json.decode(response.body);
        print(responsebody);
        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}