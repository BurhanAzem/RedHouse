import 'package:client/core/class/crud.dart';
import 'package:client/link_api.dart';
import 'dart:convert';
import 'package:client/core/class/statusrequest.dart';
import 'package:client/core/functions/checkinternet.dart';
import 'package:client/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class LoginData {

<<<<<<< HEAD
  postdata(String password, String email) async {
=======

  static postdata(String password, String email) async {
>>>>>>> d19e12219740318d11d500af635f633b653ce0be
    var data = {
      "email": email,
      "password": password,
    };
<<<<<<< HEAD
=======

>>>>>>> d19e12219740318d11d500af635f633b653ce0be
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
        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}
