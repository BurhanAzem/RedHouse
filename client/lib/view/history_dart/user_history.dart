import 'package:client/controller/applications/applications_controller.dart';
import 'package:client/controller/history_controller/history_controller.dart';
import 'package:client/model/application.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class UserHistory extends StatefulWidget {
  @override
  _UserHistoryState createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    HistoryControllerImp controller = Get.put(HistoryControllerImp());
    Application application = Get.arguments as Application;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('User History'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
          ]
        ),
      ),
    );
  }
}
