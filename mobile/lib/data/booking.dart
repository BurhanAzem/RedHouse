import 'dart:convert';
import 'package:client/core/class/statusrequest.dart';
import 'package:client/core/functions/checkinternet.dart';
import 'package:client/link_api.dart';
import 'package:client/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class BookingData {
  static createBooking(
    int userId,
    int propertyId,
    List<DateTime> bookingDays,
    // DateTime builtYear,
  ) async {
    // String formattedBuiltYear = DateFormat('yyyy-MM-ddTHH:mm:ss').format(builtYear);

    // Convert List<DateTime> to List<String>
    List<String> formattedBookingDays = bookingDays
        .map((dateTime) => DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime))
        .toList();

    var data = {
      "userId": userId,
      "propertyId": propertyId,
      "bookingDays": formattedBookingDays,
      // "builtYear": formattedBuiltYear,
    };

    if (await checkInternet()) {
      var response = await http.post(
        Uri.parse(AppLink.bookings),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${getToken()}',
        },
        body: json.encode(data),
        encoding: Encoding.getByName("utf-8"),
      );

      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = json.decode(response.body);
        print(responsebody);
        return (responsebody);
      } else {
        return (StatusRequest.serverfailure);
      }
    } else {
      return (StatusRequest.offlinefailure);
    }
  }

  static getBookingDaysForProperty(int propertyId) async {
    if (await checkInternet()) {
      final Uri uri =
          Uri.https("10.0.2.2:7042", "/properties/$propertyId/booking-days");

      var response = await http.get(uri, headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getToken()}',
      });

      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = json.decode(response.body);
        print(responsebody["listDto"]);

        return (responsebody);
      } else {
        return StatusRequest.serverfailure;
      }
    } else {
      return StatusRequest.offlinefailure;
    }
  }
}
