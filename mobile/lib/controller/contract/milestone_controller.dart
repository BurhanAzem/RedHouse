import 'package:client/data/milestones.dart';
import 'package:client/model/milestone.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class MilestoneController extends GetxController {
  MilestoneController();
}

class MilestoneControllerImp extends MilestoneController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  List<Milestone> milestones = [];
  TextEditingController milestoneName = TextEditingController();
  TextEditingController description = TextEditingController();
  DateTime milestoneDate = DateTime(2024);
  TextEditingController amount = TextEditingController();
  TextEditingController milestoneStatus = TextEditingController();
  int contractId = 1;

  addMilestone(int contractId) async {
    var response = await MilestoneData.addMilestone(
      contractId,
      milestoneName.text,
      description.text,
      milestoneDate,
      amount.text,
      milestoneStatus.text,
    );

    if (response['statusCode'] == 200) {
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

  getAllMilestonesForContract(int contractId) async {
    var response = await MilestoneData.getAllMilestonesForContract(contractId);

    if (response['statusCode'] == 200) {
      milestones = (response['listDto'] as List<dynamic>)
          .map((e) => Milestone.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

  double getSubAmountForContract() {
    double totalAmount = 0.0;
    for (Milestone milestone in milestones) {
      totalAmount += milestone.amount;
    }
    return totalAmount;
  }
}
