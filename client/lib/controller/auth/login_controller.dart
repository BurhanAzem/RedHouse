import 'package:client/core/class/crud.dart';
import 'package:client/core/class/statusrequest.dart';
import 'package:client/core/functions/handlingdata.dart';
import 'package:client/data/login.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController{
  login();
  goToSignUp();
  goToLogin();
}

class LoginControllerImp extends LoginController {

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  LoginData loginData = LoginData(new Crud());

  late TextEditingController email;
  late TextEditingController password;
  late StatusRequest statusRequest;
  List data = [];

  @override 
  login () async{
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      var response = await loginData.postdata(password.text, email.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == StatusRequest) {
        if (response['message'] == "success") {
          data.addAll(response['data']);
          // Get.offNamed(AppRoute.verfiyCodeSignUp);
        } else {
          Get.defaultDialog(title: "ُWarning" , middleText: response['message']) ; 
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
  }

  @override
  goToSignUp(){
    Get.toNamed(AppRoute.registerOne);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }


@override
  goToLogin(){
    Get.toNamed(AppRoute.login);
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}