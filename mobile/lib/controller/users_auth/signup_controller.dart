import 'package:client/core/class/statusrequest.dart';
import 'package:client/data/users_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SignUpController extends GetxController {
  signUp();
}

class SignUpControllerImp extends SignUpController {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController firstName;
  late TextEditingController lastName;
  String? userRole;
  late TextEditingController phoneNumber;
  late TextEditingController postalCode;
  late StatusRequest statusRequest;

  final formstateRegister = GlobalKey<FormState>();

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    firstName = TextEditingController();
    lastName = TextEditingController();
    userRole = "Customer";
    postalCode = TextEditingController();
    phoneNumber = TextEditingController();
    super.onInit();
  }

  @override
  signUp() async {
    if (formstateRegister.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      var response = await UserData.SignUp(
          firstName.text,
          lastName.text,
          password.text,
          phoneNumber.text,
          email.text,
          userRole!,
          postalCode.text);
      print("=============================== Controller $response ");

      if (response['statusCode'] == 200) {
        print(response['dto']);

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
