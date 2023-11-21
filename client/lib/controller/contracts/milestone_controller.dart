import 'package:client/core/class/statusrequest.dart';
import 'package:client/data/contracts.dart';
import 'package:client/data/milestones.dart';
import 'package:client/data/properties.dart';
import 'package:client/model/contract.dart';
import 'package:client/model/milestone.dart';
import 'package:client/routes.dart';
import 'package:client/view/contracts/add_milestone.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class MilestoneController extends GetxController {
  MilestoneController();
}

class MilestoneControllerImp extends MilestoneController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  List<Milestone> milestones = [];

  late TextEditingController milestoneName;
  late TextEditingController description;
  late DateTime milestoneDate;
  late TextEditingController amount;
  late TextEditingController milestoneStatus;
  late int contractId;

  addMilestone(int contractId) async{
    var response = await MilestoneData.addMilestone(
      contractId,
      milestoneName.text,
      description.text,
      milestoneDate,
      amount.text,
      milestoneStatus.text
    );

    if (response['statusCode'] == 200) {
      print("================================================== LsitDto");
      print(response['listDto']);

      // Get.offNamed(AppRoute.verfiyCodeSignUp);
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
      // applications = Application.fromJson(response);
      print(milestones);
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
    milestoneName = TextEditingController();
    description = TextEditingController();
    milestoneDate = DateTime(2024);
    amount = TextEditingController();
    milestoneStatus = TextEditingController();
    contractId = 1;
    super.onInit();
  }


}
