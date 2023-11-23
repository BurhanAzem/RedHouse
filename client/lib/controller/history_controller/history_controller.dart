import 'package:client/data/properties.dart';
import 'package:client/model/property.dart';
import 'package:client/model/user_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HistoryController extends GetxController {
  HistoryController();
}

class HistoryControllerImp extends HistoryController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  UserHistory? userHistory;
  UserHistory? propertyHistory;

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
