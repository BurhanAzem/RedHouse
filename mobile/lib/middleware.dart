import 'package:client/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (sharepref.getString("first") != null) {
      return const RouteSettings(name: "/bottom-bar");
    }
    return null;
  }
}
