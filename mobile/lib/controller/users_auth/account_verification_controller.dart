import 'package:client/core/class/statusrequest.dart';
import 'package:client/data/properties.dart';
import 'package:client/data/users_auth.dart';
import 'package:client/model/property.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AccountVerificationController extends GetxController {

  
  late int userId = 0;
  late List<String> downloadUrls = [];

  StatusRequest statusRequest = StatusRequest.loading;

  @override
  void onInit() {

    super.onInit();
  }

  @override
  VerifyAccount() async {
      statusRequest = StatusRequest.loading;
      var response = await UserData.verifyAccount(
        userId,
        downloadUrls,
      );

      if (response['statusCode'] == 200) {
        print("================================================== LsitDto");
        print(response['listDto']);
      } else {
        Get.defaultDialog(
          title: "Error",
          middleText:
              "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
        );
        statusRequest = StatusRequest.failure;
      }
    }
  }

  
  

