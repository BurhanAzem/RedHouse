import 'dart:convert';
import 'package:client/core/class/statusrequest.dart';
import 'package:client/core/functions/handlingdata.dart';
import 'package:client/data/users.dart';
import 'package:client/main.dart';
import 'package:client/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  login();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;
  late StatusRequest statusRequest;
  List data = [];

  Map<String, dynamic>? userDto;

  // instance of fireStore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  login() async {
    if (formstate.currentState!.validate()) {
      var response = await UserData.Login(password.text, email.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (response['statusCode'] == 200) {
        setToken(response['message']);

        print(
            "========================================================= response['dto']");
        print(response['dto']);

        sharepref.setString("user", jsonEncode(response['dto']));
        print(
            "========================================================= sharepref");
        print(sharepref.getString("user"));

        userDto = json.decode(sharepref.getString("user") ?? "{}");
        print(
            "========================================================= userDto");
        print(userDto);

        // add new document for ths user in users collection if it doesn't already exists
        String userId = userDto!["id"].toString();
        _fireStore.collection('users').doc(userId).set({
          'uid': userId,
          'email': userDto?["email"],
          'name': userDto?["name"],
        }, SetOptions(merge: true));

        Get.offAllNamed("/bottom-bar");
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

  String getShortenedName(String? name) {
    if (name != null) {
      final nameParts = name.split(' ');
      if (nameParts.length == 2) {
        return nameParts[0].substring(0, 1) + nameParts[1].substring(0, 1);
      } else if (nameParts.length == 1) {
        return nameParts[0].substring(0, 1);
      }
    }
    return "";
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
