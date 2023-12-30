import 'dart:convert';
import 'package:client/core/class/statusrequest.dart';
import 'package:client/core/functions/checkinternet.dart';
import 'package:client/link_api.dart';
import 'package:client/model/location.dart';
import 'package:client/shared_preferences.dart';
import 'package:client/model/neighborhood/neighborhoodDto.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class PropertyData {
  static addProperty(
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
    dynamic longitude,
    List<NeighborhoodDto> propertyNeighborhoods,
  ) async {
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
      "isAvailableBasement": isAvailableBasement == 'Yes' ? "true" : "false",
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
      "propertyFiles": downloadUrls,
      "neighborhoodDtos": propertyNeighborhoods,
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
        return (responsebody);
      } else {
        return (StatusRequest.serverfailure);
      }
    } else {
      return (StatusRequest.offlinefailure);
    }
  }

  static Future<dynamic> getProperties(
    List<String> propertyTypes,
    String minPrice,
    String maxPrice,
    String numberOfBathrooms,
    String numberOfBedrooms,
    String view,
    String listingType,
    Location location,
    List<String> propertyStatus,
    String minPropertySize,
    String maxPropertySize,
    String minBuiltYear,
    String maxBuiltYear,
    String parkingSpots,
    String rentType,
    bool hasBassmentUnit,
  ) async {
    final Map<String, dynamic> filters = {
      "PropertyTypes": propertyTypes,
      "MinPrice": minPrice,
      "MaxPrice": maxPrice,
      "NumberOfBedRooms": numberOfBedrooms,
      "NumberOfBathRooms": numberOfBathrooms,
      "View": view == "Any" ? "" : view,
      "ListingType": listingType,
      "LocationDto.StreetAddress": location.streetAddress,
      "LocationDto.City": location.city,
      "LocationDto.Region": location.region,
      "LocationDto.PostalCode": location.postalCode,
      "LocationDto.Country": location.country,
      "LocationDto.Latitude":
          location.latitude == 0.0 ? "" : location.latitude.toString(),
      "LocationDto.Longitude":
          location.longitude == 0.0 ? "" : location.longitude.toString(),
      "propertyStatus": propertyStatus,
      "minPropertySize": minPropertySize,
      "maxPropertySize": maxPropertySize,
      "minBuiltYear": minBuiltYear,
      "maxBuiltYear": maxBuiltYear,
      "parkingSpots": parkingSpots,
      "rentType": rentType,
      "hasBasement":
          hasBassmentUnit.toString(), // Assuming 1 for true and 0 for false
    };

    if (await checkInternet()) {
      final Uri uri = Uri.https("10.0.2.2:7042", "/properties", filters);

      try {
        var response = await http.get(uri, headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${getToken()}',
        });

        print(response.statusCode);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> responseBody = json.decode(response.body);
          print(responseBody["listDto"]);

          return responseBody;
        } else {
          return StatusRequest.serverfailure;
        }
      } catch (e) {
        print(e.toString());
        return StatusRequest.serverfailure;
      }
    } else {
      return StatusRequest.offlinefailure;
    }
  }

  static getProperty(int id) async {
    if (await checkInternet()) {
      var response = await http.get(Uri.parse('${AppLink.properties}/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${getToken()}',
          });
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = json.decode(response.body);
        print(responsebody["dto"]);

        return (responsebody);
      } else {
        return StatusRequest.serverfailure;
      }
    } else {
      return StatusRequest.offlinefailure;
    }
  }

  static getListAutoCompleteLocation(String query) async {
    if (await checkInternet()) {
      var response = await http.get(
          Uri.parse('${AppLink.properties}/auto-complete-location/$query'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${getToken()}',
          });
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = json.decode(response.body);
        print(responsebody["dto"]);

        return (responsebody);
      } else {
        return StatusRequest.serverfailure;
      }
    } else {
      return StatusRequest.offlinefailure;
    }
  }

  static getPropertiesForUser(int userId, String propertiesFilter) async {
    final Map<String, dynamic> filters = {
      "propertiesFilter": propertiesFilter,
    };

    if (await checkInternet()) {
      final Uri uri =
          Uri.https("10.0.2.2:7042", "/users/$userId/properties", filters);

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

  static getNeighborhoodsForProperty(int propertyId) async {
    if (await checkInternet()) {
      final Uri uri = Uri.https("10.0.2.2:7042", "/neighborhoods/$propertyId");

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
}
