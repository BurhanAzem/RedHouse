import 'package:client/data/history.dart';
import 'package:client/model/user_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  List<UserHistory> userHistory = [];
  List<UserHistory> propertyHistory = [];

  getHistoryUser(int userId) async {
    var response = await UserHistoryData.getUserHistory(userId);

    if (response['statusCode'] == 200) {
      userHistory = (response['listDto'] as List<dynamic>)
          .map((e) => UserHistory.fromJson(e as Map<String, dynamic>))
          .toList();
      print(userHistory);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

  getHistoryProperty(int propertId) async {
    var response = await UserHistoryData.getPropertyHistory(propertId);

    if (response['statusCode'] == 200) {
      propertyHistory = (response['listDto'] as List<dynamic>)
          .map((e) => UserHistory.fromJson(e as Map<String, dynamic>))
          .toList();
      print(propertyHistory);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

  // Get all users who have an approved application between them and this user, to open messages between them
  // List<User> usersApprovedApplications = [];
  // getUsersApprovedApplications(int userId) async {
  //   var response = await UserHistoryData.getUsersApprovedApplications(userId);

  //   if (response['statusCode'] == 200) {
  //     usersApprovedApplications = (response['listDto'] as List<dynamic>)
  //         .map((e) => User.fromJson(e as Map<String, dynamic>))
  //         .toList();
  //     print(usersApprovedApplications);
  //   } else {
  //     Get.defaultDialog(
  //       title: "Error",
  //       middleText:
  //           "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
  //     );
  //   }
  // }
}
