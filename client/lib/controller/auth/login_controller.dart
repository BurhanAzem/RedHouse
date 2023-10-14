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

  late TextEditingController email;
  late TextEditingController password;

  @override 
  login(){
    var formdata = formstate.currentState;
    if(formdata!.validate()){
      print("Valid");
    } else {
      print("Not valid");
    }
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