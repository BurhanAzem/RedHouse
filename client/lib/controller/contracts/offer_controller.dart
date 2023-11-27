import 'package:client/data/offers.dart';
import 'package:client/model/offer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  String offerStatusSelect = "All";
  String offerToSelect = "All";

  late List<Offer> userOffers;

  int landlordId = 1;
  int customerId = 1;
  int propertyId = 1;
  late TextEditingController description;
  late DateTime offerExpireDate;
  late DateTime offerDate = DateTime.now();
  late TextEditingController price;
  late String offerStatus = "Pendding";

  createOffer() async {
    var response = await OfferData.createOffer(
      landlordId,
      customerId,
      propertyId,
      price.text,
      description.text,
      offerStatus,
      offerExpireDate,
      offerDate,
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

  @override
  void onInit() {
    description = TextEditingController();
    offerExpireDate = DateTime(2024);
    price = TextEditingController();
    super.onInit();
  }
}
