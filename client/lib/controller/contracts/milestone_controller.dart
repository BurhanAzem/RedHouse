import 'package:client/core/class/statusrequest.dart';
import 'package:client/data/contracts.dart';
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

  late TextEditingController milestoneName;
  late TextEditingController description;
  late DateTime milestoneDate;
  late TextEditingController amount;
  late TextEditingController milestoneStatus;
  late int contractId;



  addMilestone(){
    
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
