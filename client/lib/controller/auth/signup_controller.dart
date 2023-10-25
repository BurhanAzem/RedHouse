import 'package:client/core/class/crud.dart';
import 'package:client/core/class/statusrequest.dart';
import 'package:client/core/functions/handlingdata.dart';
import 'package:client/data/signup.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToLogin();
  goToRegisterTwo();
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

  SignupData signupData = SignupData(new Crud());

  List data = [];

  @override
  signUp() async {
    if (formstateRegister.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      var response = await signupData.postdata(
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
        data.addAll(response['data']);
        // Get.offNamed(AppRoute.verfiyCodeSignUp);
      } else {
        Get.defaultDialog(
          title: "Error",
          middleText:
              "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
        );
        statusRequest = StatusRequest.failure;
      }

      update();
    }
  }

  @override
  goToLogin() {
    Get.toNamed(AppRoute.login);
  }

  @override
  goToRegisterTwo() {
    Get.toNamed(AppRoute.registerTwo);
  }

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
