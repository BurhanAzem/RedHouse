import 'package:client/data/applications.dart';
import 'package:client/model/application.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationsController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  List<Application> applications = [];

  String? applicationType = "All";
  String? applicationStatus = "All";

  int propertyId = 1;
  int userId = 1; // customer id
  DateTime applicationDate = DateTime.now();
  TextEditingController message = TextEditingController();
  String aapplicationStatus = "Pendding";
  TextEditingController suggestedPrice = TextEditingController();

  addApplication() async {
    var response = await ApplicationData.addApplication(
      propertyId,
      userId,
      applicationDate,
      message.text,
      aapplicationStatus,
      int.tryParse(suggestedPrice.text) ?? 0,
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
    }
  }

  getApplications(int userId) async {
    var response = await ApplicationData.getApplications(userId);

    if (response['statusCode'] == 200) {
      applications = (response['listDto'] as List<dynamic>)
          .map((e) => Application.fromJson(e as Map<String, dynamic>))
          .toList();
      print(applications);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

  approvedApplication(int id) async {
    var response = await ApplicationData.approvedApplication(id);
    print(response['message']);
  }

  deleteApplication(int id) async {
    var response = await ApplicationData.deleteApplication(id);
    print(response['message']);
  }
}
