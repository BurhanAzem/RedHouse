import 'package:client/core/class/statusrequest.dart';
import 'package:client/data/contracts.dart';
import 'package:client/data/properties.dart';
import 'package:client/model/contract.dart';
import 'package:client/model/milestone.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AllContractsController extends GetxController {
  AllContractsController();
}

class ContractsControllerImp extends AllContractsController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  int activeStep = 0;

  String contractStatus = "All";
  String contractType = "All";
  String contractTo = "Landlord";
  int userId = 1;
  List<Contract> contracts = [];
  // List<Milestone>? milestones = [
  //   Milestone(
  //       id: 1,
  //       milestoneName: 'Payment of dues for the month of October 10',
  //       description:
  //           'Payment of dues for the month of October 10 Payment of dues for the month of October 10Payment of dues for the month of October 10 Payment of dues for the month of October 10Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10',
  //       milestoneDate: '2023-11-11',
  //       amount: 100,
  //       milestoneStatus: 'Paid',
  //       contractId: 2),
  //       Milestone(
  //       id: 1,
  //       milestoneName: 'Payment of dues for the month of October 10',
  //       description:
  //           'Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10',
  //       milestoneDate: '2023-11-11',
  //       amount: 100,
  //       milestoneStatus: 'Paid',
  //       contractId: 2),
  //       Milestone(
  //       id: 1,
  //       milestoneName: 'Payment of dues for the month of October 10',
  //       description:
  //           'Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10',
  //       milestoneDate: '2023-11-11',
  //       amount: 100,
  //       milestoneStatus: 'Paid',
  //       contractId: 2),
  //       Milestone(
  //       id: 1,
  //       milestoneName: 'Payment of dues for the month of October 10',
  //       description:
  //           'Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10',
  //       milestoneDate: '2023-11-11',
  //       amount: 100,
  //       milestoneStatus: 'Paid',
  //       contractId: 2),
  //       Milestone(
  //       id: 1,
  //       milestoneName: 'Payment of dues for the month of October 10',
  //       description:
  //           ' Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10',
  //       milestoneDate: '2023-11-11',
  //       amount: 100,
  //       milestoneStatus: 'Pending',
  //       contractId: 2),
  //       Milestone(
  //       id: 1,
  //       milestoneName: 'Payment of dues for the month of October 10',
  //       description:
  //           'Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10 Payment of dues for the month of October 10',
  //       milestoneDate: '2023-11-11',
  //       amount: 100,
  //       milestoneStatus: 'Pending',
  //       contractId: 2),
  // ];

  getAllContrcats() async {
    var response = await ContractsData.getContrcats(
        userId, contractStatus, contractType, contractTo);

    if (response['statusCode'] == 200) {
      contracts = (response['listDto'] as List<dynamic>)
          .map((e) => Contract.fromJson(e as Map<String, dynamic>))
          .toList();
      // applications = Application.fromJson(response);
      print(contracts);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }
}
