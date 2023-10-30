
import 'package:client/core/class/crud.dart';
import 'package:client/link_api.dart';
import 'dart:convert';
import 'package:client/core/class/statusrequest.dart';
import 'package:client/core/functions/checkinternet.dart';
import 'package:client/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class SignUpData {

  static postdata(
      String firstName,
      String lastName,
      String password,
      String phoneNumber,
      String email,
      String userRole,
      String postalCode) async {
    var data = {
      "name": firstName.toString() + " " + lastName.toString(),
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
        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}
