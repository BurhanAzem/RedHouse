import 'package:client/data/applications.dart';
import 'package:client/data/properties.dart';
import 'package:client/model/application.dart';
import 'package:client/model/property.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HistoryController extends GetxController {
  HistoryController();
  

}

class HistoryControllerImp extends HistoryController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  // List<Application> applications = [];
  // String? applicationType = "All";
  // String? applicationStatus = "All";


  getHistoryUser(int userId) async {
    var response = await ApplicationData.getApplications(userId);

    if (response['statusCode'] == 200) {
      var userHistory = (response['dto'] as List<dynamic>)
          .map((e) => Application.fromJson(e as Map<String, dynamic>))
          .toList();
      // applications = Application.fromJson(response);
      print(userHistory);
      return userHistory;
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

  getApplication() async {
    var response = await PropertyData.getProperty(4);

    if (response['statusCode'] == 200) {
      var property = Property.fromJson(response['dto']);
      print(property);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

  @override
  void onInit() {
    
    super.onInit();
  }

}
