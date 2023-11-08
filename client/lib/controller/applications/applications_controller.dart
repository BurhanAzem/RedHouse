import 'package:client/core/class/statusrequest.dart';
import 'package:client/data/applications.dart';
import 'package:client/data/properties.dart';
import 'package:client/data/user_history.dart';
import 'package:client/model/application.dart';
import 'package:client/model/contract.dart';
import 'package:client/model/property.dart';
import 'package:client/model/user_history.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ContractsController extends GetxController {
  ContractsController();
  goToContract();

}

class ApplicationsControllerImp extends ContractsController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  List<Application> applications = [];
  List<UserHistory> userHistory = [];

  String? applicationType = "All";
  String? applicationStatus = "All";


  getApplications(int userId) async {
    var response = await ApplicationData.getApplications(userId);

    if (response['statusCode'] == 200) {
      applications = (response['listDto'] as List<dynamic>)
          .map((e) => Application.fromJson(e as Map<String, dynamic>))
          .toList();
      // applications = Application.fromJson(response);
      print(applications);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }


  getHistoryUser(int userId) async {
    var response = await UserHistoryData.getUserHistory(userId);

    if (response['statusCode'] == 200) {
      userHistory = (response['listDto'] as List<dynamic>)
          .map((e) => UserHistory.fromJson(e as Map<String, dynamic>))
          .toList();
      // applications = Application.fromJson(response);
      print(userHistory);
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

  @override
  goToAddProperty1() {
    Get.toNamed(AppRoute.addProperty1);
  }

  @override
  goToAddProperty2() {
    Get.toNamed(AppRoute.addProperty2);
  }

  @override
  goToAddProperty3() {
    Get.toNamed(AppRoute.addProperty3);
  }

  @override
  goToAddProperty4() {
    Get.toNamed(AppRoute.addProperty4);
  }

  @override
  goToAddProperty5() {
    Get.toNamed(AppRoute.addProperty5);
  }

  @override
  goToAddProperty6() {
    Get.toNamed(AppRoute.addProperty6);
  }

  @override
  goToAddProperty7() {
    Get.toNamed(AppRoute.addProperty7);
  }

  @override
  goToAddProperty8() {
    Get.toNamed(AppRoute.addProperty8);
  }

  @override
  goToAddProperty9() {
    Get.toNamed(AppRoute.addProperty9);
  }

  @override
  goToContract() {
    // Get.toNamed(AppRoute.contract);
  }
}
