import 'dart:convert';
import 'package:client/core/class/crud.dart';
import 'package:client/core/class/statusrequest.dart';
import 'package:client/core/functions/handlingdata.dart';
import 'package:client/data/login.dart';
import 'package:client/main.dart';
import 'package:client/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  login();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  LoginData loginData = LoginData(Crud());

  late TextEditingController email;
  late TextEditingController password;
  late StatusRequest statusRequest;
  List data = [];

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  login() async {
    if (formstate.currentState!.validate()) {
      var response = await loginData.postdata(password.text, email.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (response['statusCode'] == 200) {
        print(response['dto']);
        setToken(response['message']);
        final userDtoJson =
            jsonEncode(response['dto']); // Convert the DTO to JSON
        setUser(userDtoJson);
        // sharepref!.setString("user", userDtoJson);
        print("===============================================");
        print(getUser());
        // print(sharepref!.getString("user"));
        Get.toNamed("/bottom-bar");
        sharepref!.setString("visitor", "no");
      } else {
        Get.defaultDialog(
            title: "ُWarning",
            middleText:
                'There is something wronge ! \n statusCode: $response.["statusCode"], exceptions: $response.["exceptions"]');
        statusRequest = StatusRequest.failure;
      }
      return;
    }

    // update();
    else {
      Get.defaultDialog(
          title: "ُWarning", middleText: 'There is something wronge!');
      statusRequest = StatusRequest.failure;
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}









// import 'dart:convert';
// import 'package:client/core/class/crud.dart';
// import 'package:client/core/class/statusrequest.dart';
// import 'package:client/core/functions/handlingdata.dart';
// import 'package:client/data/login.dart';
// import 'package:client/main.dart';
// import 'package:client/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// abstract class LoginController extends GetxController {
//   login();
// }

// class LoginControllerImp extends LoginController {
//   GlobalKey<FormState> formstate = GlobalKey<FormState>();
//   LoginData loginData = LoginData(Crud());

//   late TextEditingController email;
//   late TextEditingController password;
//   late StatusRequest statusRequest;
//   List data = [];

//   @override
//   login() async {
//     if (formstate.currentState!.validate()) {
//       // statusRequest = StatusRequest.loading;
//       var response = await loginData.postdata(password.text, email.text);
//       print("=============================== Controller $response ");
//       statusRequest = handlingData(response);
//       if (response['statusCode'] == 200) {
//         print(response['dto']);
// <<<<<<< HEAD
//         setToken(response['message']);
//         final userDtoJson =
//             jsonEncode(response['dto']); // Convert the DTO to JSON
//         setUser(userDtoJson);
//         print(getUser());
//         Get.toNamed("/search");
//         sharepref!.setString("visitor", "no");
//       } else {
//         Get.snackbar("ُWarning",
//             'There is something wronge ! \n statusCode: $response.["statusCode"], exceptions: $response.["exceptions"]');
// =======
//           setToken(response['message']);
//           final userDtoJson = jsonEncode(response['dto']); // Convert the DTO to JSON
//           setUser(userDtoJson);
//           print(getUser());
//           goToBottomBar();
//       } else {
//         Get.defaultDialog(
//             title: "ُError",
//             middleText:
//                 'There is something wronge ! \n statusCode: $response["statusCode"], exception: $response["exception"]');
// >>>>>>> cb5ec897582a0ab1b90e1a6b0906c20767c4688c
//         statusRequest = StatusRequest.failure;
//       }
//       return;
//     }

//     // update();
//     else {
//       Get.snackbar("ُWarning", 'There is something wronge!');
//       statusRequest = StatusRequest.failure;
//     }
//   }

//   @override
//   void onInit() {
//     email = TextEditingController();
//     password = TextEditingController();
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     email.dispose();
//     password.dispose();
//     super.dispose();
//   }
// }
