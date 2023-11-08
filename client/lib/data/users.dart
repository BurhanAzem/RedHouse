import 'package:client/link_api.dart';
import 'dart:convert';
import 'package:client/core/class/statusrequest.dart';
import 'package:client/core/functions/checkinternet.dart';
import 'package:client/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class UserData {


  static Login(String password, String email) async {
    var data = {
      "email": email,
      "password": password,
    };
    if (await checkInternet()) {
      var response = await http.post(Uri.parse(AppLink.login),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $getToken()'
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

  static SignUp(
      String firstName,
      String lastName,
      String password,
      String phoneNumber,
      String email,
      String userRole,
      String postalCode) async {
    var data = {
      "name": "$firstName $lastName",
      "password": password,
      "email": email,
      "phoneNumber": phoneNumber,
      "userRole": userRole,
      "zipCode": postalCode
    };

    if (await checkInternet()) {
      var response = await http.post(Uri.parse(AppLink.register),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $getToken()'
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

  static getUser(
  int id
) async {

  if (await checkInternet()) {
    // final Uri uri = Uri.https("10.0.2.2:7042", "/properties",);

    var response = await http.get(Uri.parse(AppLink.users+'/$id'), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${getToken()}',
    });
    print(response.statusCode);
    // print(response.body.listDto);

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




}
