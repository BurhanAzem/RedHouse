import 'dart:convert';
import 'package:client/core/class/statusrequest.dart';
import 'package:client/core/functions/checkinternet.dart';
import 'package:client/link_api.dart';
import 'package:client/model/location.dart';
import 'package:client/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class MilestoneData {
  static addMilestone(
      int contractId,
      String milestoneName,
      String description,
      DateTime milestoneDate,
      String amount,
      String milestoneStatus
) async {

    String formattedmilestoneDate =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(milestoneDate);

    var data = {
        "contractId": contractId, 
          "milestoneName": milestoneName,
          "description": description,
          "milestoneDate": formattedmilestoneDate,
          "amount": int.tryParse(amount) ?? 0,
          "milestoneStatus": "Pending"
     
    };
    if (await checkInternet()) {
      var response = await http.post(Uri.parse(AppLink.milestones),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $getToken()()'
          },
          body: json.encode(data),
          encoding: Encoding.getByName("utf-8"));
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
    // return response.fold((l) => l, (r) => r);
  }

  static getAllMilestonesForContract(int contractId) async {
    
    if (await checkInternet()) {
      final Uri uri = Uri.https("10.0.2.2:7042", "/contracts/$contractId/milestones");

      var response = await http.get(uri, headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getToken()}',
      });

      print(response.statusCode);
      // print(response.body.listDto);

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
