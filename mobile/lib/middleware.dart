import 'dart:convert';
import 'package:client/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleWare extends GetMiddleware {
  Map<String, dynamic>? userDto =
      json.decode(sharepref.getString("user") ?? "{}");
  @override
  RouteSettings? redirect(String? route) {
    if (sharepref.getString("first") != null) {
      if (userDto?["userRole"] == "lawyer") {
        return const RouteSettings(name: "/lawyer-bottom-bar");
      } else {
        return const RouteSettings(name: "/bottom-bar");
      }
    }
    return null;
  }
}
