import 'dart:convert';
import 'package:client/data/offers.dart';
import 'package:client/model/offer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  String offerTypeSelect = "All";
  String offerStatusSelect = "All";
  String offerToSelect = "All";

  late List<Offer> userOffers;

  int landlordId = 1;
  int customerId = 1;
  int propertyId = 1;
  late TextEditingController description;
  DateTime offerExpireDate = DateTime.now();
  DateTime offerDate = DateTime.now();
  late TextEditingController price;
  late String offerStatus = "Pendding";

  String responseMessage = "";

  @override
  void onInit() {
    description = TextEditingController();
    offerExpireDate = DateTime(2024);
    price = TextEditingController();
    super.onInit();
  }

  createOffer() async {
    var response = await OfferData.createOffer(
      landlordId,
      customerId,
      propertyId,
      price.text,
      description.text,
      offerStatus,
      offerExpireDate!,
      offerDate,
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

    // if (response['statusCode'] == 200) {
    //   print(response['listDto']);
    // } else {
    //   Get.defaultDialog(
    //     title: "Error",
    //     middleText:
    //         "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
    //   );
    // }
  }

  getAllOffersForUser(int userId) async {
    var response = await OfferData.getAllOffersForUser(
        userId, offerStatusSelect, offerToSelect);

    if (response['statusCode'] == 200) {
      userOffers = (response['listDto'] as List<dynamic>)
          .map((e) => Offer.fromJson(e as Map<String, dynamic>))
          .toList();
      print(userOffers);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

  acceptOffer(int offerId) async {
    var response = await OfferData.acceptOffer(offerId);
    print(response);
  }

  deleteOffer(int id) async {
    var response = await OfferData.deleteOffer(id);
    print(response['message']);
  }
}
