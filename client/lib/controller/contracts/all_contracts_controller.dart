import 'package:client/core/class/statusrequest.dart';
import 'package:client/data/contracts.dart';
import 'package:client/data/properties.dart';
import 'package:client/model/contract.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AllContractsController extends GetxController {
  AllContractsController();
}

class AllContractsControllerImp extends AllContractsController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  int activeStep = 0;

  String contractStatus = "All";
  String contractType = "All";
  String contractTo = "Landlord";
  int userId = 1;
  List<Contract>? contracts = [];

getAllContrcats() async {
    var response = await ContractsData.getContrcats(userId, contractStatus, contractType, contractTo);

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
