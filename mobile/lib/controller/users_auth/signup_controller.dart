import 'dart:convert';
import 'package:client/core/class/statusrequest.dart';
import 'package:client/data/users_auth.dart';
import 'package:client/main.dart';
import 'package:client/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpControllerImp extends GetxController {
  int landlordScore = 0;
  int customerScore = 0;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController firstName;
  late TextEditingController lastName;
  late String userRole;
  late TextEditingController phoneNumber;
  late TextEditingController postalCode;
  late StatusRequest statusRequest;

  GlobalKey<FormState> formstateRegister = GlobalKey<FormState>();
  GlobalKey<FormState> formstateUpdate = GlobalKey<FormState>();

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    firstName = TextEditingController();
    lastName = TextEditingController();
    postalCode = TextEditingController();
    phoneNumber = TextEditingController();
    userRole = "Basic Account";
    super.onInit();
  }

  signUp() async {
    if (formstateRegister.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      var response = await UserData.signUp(
          firstName.text,
          lastName.text,
          password.text,
          phoneNumber.text,
          email.text,
          userRole,
          postalCode.text);

      if (response['statusCode'] == 200) {
        Get.offAllNamed("/login");
      } else {
        Get.defaultDialog(
          title: "Error",
          middleText:
              "statusCode: ${response['statusCode']}, exception: ${response['exception']}",
        );
        statusRequest = StatusRequest.failure;
      }

      update();
    }
  }

  updateUser(int userId) async {
    var response = await UserData.updateUser(
      userId,
      firstName.text,
      lastName.text,
      email.text,
      phoneNumber.text,
      password.text,
    );

    print(response);

    if (response is Map<String, dynamic> && response['statusCode'] == 200) {
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

  // updateUserScore(int userId) async {
  //   var response = await UserData.updateUserScore(
  //     userId,
  //     landlordScore,
  //     customerScore,
  //     userRole,
  //   );

  //   if (response is Map<String, dynamic> && response['statusCode'] == 200) {
  //   } else {
  //     Get.defaultDialog(
  //       title: "Error",
  //       middleText:
  //           "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
  //     );
  //   }
  // }

  updateUserVerified(int userId, bool isVerified) async {
    var response = await UserData.updateUserVerified(userId, isVerified);

    if (response is Map<String, dynamic> && response['statusCode'] == 200) {
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

  getUser(int userId) async {
    var response = await UserData.getUser(userId);

    if (response['statusCode'] == 200) {
      sharepref.setString(
        "user",
        jsonEncode(
            User.fromJson(response['dto'] as Map<String, dynamic>).toJson()),
      );
      print(sharepref.getString("user"));
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    firstName.dispose();
    lastName.dispose();
    phoneNumber.dispose();
    postalCode.dispose();
    super.dispose();
  }
}
