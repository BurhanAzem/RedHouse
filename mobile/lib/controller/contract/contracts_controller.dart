import 'package:client/data/contracts.dart';
import 'package:client/model/contract.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContractsController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  int activeStep = 0;

  String contractStatus = "All";
  String contractType = "All";
  String contractTo = "Landlord";
  int userId = 1;
  List<Contract> contracts = [];
  Contract? contractIsCreated;
  String responseMessage = "";

  getAllContrcats() async {
    var response = await ContractsData.getContrcats(
        userId, contractStatus, contractType, contractTo);
    if (response is Map<String, dynamic>) {
      if (response['statusCode'] == 200) {
        contracts = (response['listDto'] as List<dynamic>)
            .map((e) => Contract.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        Get.defaultDialog(
          title: "Error",
          middleText:
              "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
        );
      }
    }
  }

  getContractForOffer(int offerId) async {
    var response = await ContractsData.getContractForOffer(offerId);

    if (response['statusCode'] == 200) {
      if (response['dto'] != null) {
        contractIsCreated =
            Contract.fromJson(response['dto'] as Map<String, dynamic>);
      }
      responseMessage = response['message'];
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }
}
