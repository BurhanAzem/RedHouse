import 'package:client/data/booking.dart';
import 'package:flutter/material.dart';
import 'package:client/model/booking.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  List<DateTime> preBookedDays = [];
  int userId = 1;
  int propertyId = 1;
  List<DateTime> bookingDays = [];
  String bookingCode = "";
  String bookingTo = "Customer";
  List<Booking> userBookings = [];

  TextEditingController cardNumber = TextEditingController();
  TextEditingController cardName = TextEditingController();
  TextEditingController cardCCV = TextEditingController();
  TextEditingController cardDate = TextEditingController();

  createBooking() async {
    var response =
        await BookingData.createBooking(userId, propertyId, bookingDays);

    if (response['statusCode'] == 200) {
      print(response['listDto']);
      bookingCode = response['dto']['bookingCode'];
      print(bookingCode);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

  getBookingDaysForProperty(int propertyId) async {
    var response = await BookingData.getBookingDaysForProperty(propertyId);

    if (response['statusCode'] == 200) {
      preBookedDays = (response['listDto'] as List<dynamic>)
          .map((e) => DateTime.parse(e['dayDate']))
          .toList();
      print(preBookedDays);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

  getBookingsForUser(int userId) async {
    var response = await BookingData.getUserBookings(userId, bookingTo);

    if (response['statusCode'] == 200) {
      userBookings = (response['listDto'] as List<dynamic>)
          .map((e) => Booking.fromJson(e as Map<String, dynamic>))
          .toList();
      print(userBookings);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }
}
