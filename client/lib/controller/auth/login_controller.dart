import 'dart:convert';

import 'package:client/core/class/crud.dart';
import 'package:client/core/class/statusrequest.dart';
import 'package:client/core/functions/handlingdata.dart';
import 'package:client/data/login.dart';
import 'package:client/routes.dart';
import 'package:client/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToLogin();
  goToSearch();
  goToBottomBar();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  LoginData loginData = LoginData(new Crud());

  late TextEditingController email;
  late TextEditingController password;
  late StatusRequest statusRequest;
  List data = [];

  @override
  login() async {
    if (formstate.currentState!.validate()) {
      // statusRequest = StatusRequest.loading;
      var response = await loginData.postdata(password.text, email.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (response['statusCode'] == 200) {
        print(response['dto']);
          setToken(response['message']);
          final userDtoJson = jsonEncode(response['dto']); // Convert the DTO to JSON
          setUser(userDtoJson);
          print(getUser());
          goToBottomBar();
      } else {
        Get.defaultDialog(
            title: "ُError",
            middleText:
                'There is something wronge ! \n statusCode: $response["statusCode"], exception: $response["exception"]');
        statusRequest = StatusRequest.failure;
      }
      return;
    }

    // update();
    else {
      Get.defaultDialog(
          title: "ُError", middleText: 'There is something wronge !');
      statusRequest = StatusRequest.failure;
    }
  }

  @override
  goToSignUp() {
    Get.toNamed(AppRoute.registerOne);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  goToLogin() {
    Get.toNamed(AppRoute.login);
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToSearch() {
    Get.toNamed(AppRoute.search);
  }

  @override
  goToBottomBar() {
    Get.toNamed(AppRoute.bottomBar);
  }
}
