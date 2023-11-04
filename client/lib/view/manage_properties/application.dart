import 'package:client/controller/applications/applications_controller.dart';
import 'package:client/model/application.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationDetails extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<ApplicationDetails> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    ApplicationsControllerImp controller =
      Get.put(ApplicationsControllerImp());
    Application application = Get.arguments as Application;
      
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Payments timeline'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Text(application.user.Name!)
          ],
        ),
      ),
     
    );
  }

 
}
