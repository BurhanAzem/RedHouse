import 'package:client/data/booking.dart';
import 'package:client/data/complaint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  int userId = 1;
  String description = "";

  sendComplaint() async {
    var response = await ComplaintData.sendComplaint(userId, description);

    print(response['listDto']);

    if (response['statusCode'] == 200) {
      print(response['listDto']);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }
}
