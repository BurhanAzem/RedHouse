import 'dart:convert';
import 'package:client/data/applications.dart';
import 'package:client/model/application.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationsController extends GetxController {
  List<Application> applications = [];
  List<Application> approvedApplicationsForUser = [];

  String? applicationType = "All";
  String? applicationStatus = "All";
  String? applicationTo = "Landlord";

  int propertyId = 1;
  int userId = 1; // customer id
  DateTime applicationDate = DateTime.now();
  TextEditingController message = TextEditingController();
  String _applicationStatus = "Pendding";
  TextEditingController suggestedPrice = TextEditingController();

  String responseMessage = "";

  addApplication() async {
    var response = await ApplicationData.addApplication(
      propertyId,
      userId,
      applicationDate,
      message.text,
      _applicationStatus,
      int.tryParse(suggestedPrice.text) ?? 0,
    );

    print(response);
    Map responsebody = json.decode(response.body);
    print(responsebody);
    responseMessage = responsebody["message"];
    print(responseMessage);

    if (responsebody.length != 1) {
      if (responsebody['statusCode'] == 200) {
        print(responsebody['listDto']);
        print(responseMessage);
      } else {
        Get.defaultDialog(
          title: "Error",
          middleText:
              "statusCode: ${responsebody['statusCode']}, exceptions: ${responsebody['exceptions']}",
        );
      }
    }
  }

  getApplications(int userId) async {
    var response = await ApplicationData.getApplications(
        userId, applicationStatus, applicationType, applicationTo);

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

  ignoreApplication(int id) async {
    var response = await ApplicationData.ignoreApplication(id);
    print(response['message']);
  }

  deleteApplication(int id) async {
    var response = await ApplicationData.deleteApplication(id);
    print(response['message']);
  }

  // Get all approved applications for user, to open messages between customer and landlord
  getApprovedApplicationsForUser(int userId) async {
    var response = await ApplicationData.getApprovedApplicationsForUser(userId);

    if (response['statusCode'] == 200) {
      approvedApplicationsForUser = (response['listDto'] as List<dynamic>)
          .map((e) => Application.fromJson(e as Map<String, dynamic>))
          .toList();
      print(approvedApplicationsForUser);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }
}
