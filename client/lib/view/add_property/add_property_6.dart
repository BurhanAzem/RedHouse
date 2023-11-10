import 'package:client/controller/manage_propertise/manage_property_controller.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProperty6 extends StatefulWidget {
  AddProperty6({Key? key}) : super(key: key);

  @override
  _AddProperty6State createState() => _AddProperty6State();
}

class _AddProperty6State extends State<AddProperty6> {
  ManagePropertyControllerImp controller =
      Get.put(ManagePropertyControllerImp(), permanent: true);

  Future<void> _selectDateAvialableOn() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.utc(1800, 7, 20),
      lastDate: DateTime.now().add(Duration(days: 365 * 10)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: Color(0xffd92328), // Change the color of the header
            // accentColor: Color(0xffd92328), // Change the color of the selected date
          ),
          child: child ?? Container(),
        );
      },
      // Define the theme for the date picker buttons here
      // To change the button color, you can define your custom DatePickerTheme
      // and set the button color within it.
      // Example:
      // theme: DatePickerTheme(
      //   doneStyle: TextStyle(color: Color(0xffd92328)),
      //   cancelStyle: TextStyle(color: Color(0xffd92328)),
      // ),
    );

    if (pickedDate != null) {
      setState(() {
        controller.availableDate = pickedDate;
      });
    }
  }

    Future<void> _selectDateBuitYear() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.utc(1800, 7, 20),
      lastDate: DateTime.now().add(Duration(days: 365 * 10)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: Color(0xffd92328), // Change the color of the header
            // accentColor: Color(0xffd92328), // Change the color of the selected date
          ),
          child: child ?? Container(),
        );
      },
      // Define the theme for the date picker buttons here
      // To change the button color, you can define your custom DatePickerTheme
      // and set the button color within it.
      // Example:
      // theme: DatePickerTheme(
      //   doneStyle: TextStyle(color: Color(0xffd92328)),
      //   cancelStyle: TextStyle(color: Color(0xffd92328)),
      // ),
    );

    if (pickedDate != null) {
      setState(() {
        controller.builtYear = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Red",
              style: TextStyle(
                color: Color(0xffd92328),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "House Manage Properties",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EasyStepper(
                    finishedStepBackgroundColor: Color(0xffd92328),
                    activeStepBorderColor: Colors.black,
                    stepShape: StepShape.circle,
                    lineStyle: LineStyle(),

                    activeStep: controller.activeStep,
                    activeStepTextColor: Colors.black87,
                    finishedStepTextColor: Colors.black87,
                    internalPadding: 0,
                    // showScrollbar: false,
                    fitWidth: true,
                    showLoadingAnimation: false,
                    stepRadius: 5,
                    showStepBorder: false,
                    steps: [
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 0 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'Waiting',
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 1 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'Order Received',
                        topTitle: true,
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 2 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'Preparing',
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 3 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'On Way',
                        topTitle: true,
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 4 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'Delivered',
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 5 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'Delivered',
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 6 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'Delivered',
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 7 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'Delivered',
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                controller.activeStep >= 8 ? Color(0xffd92328) : Colors.grey,
                          ),
                        ),
                        // title: 'Delivered',
                      ),
                      
                    ],
                    onStepReached: (index) =>
                        setState(() => controller.activeStep = index),
                  ),
                  Image.asset("assets/images/logo.png", scale: 10),
                  Container(height: 5),
                  Text(
                    "When is your property available to rent?",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                    
                      onPressed: _selectDateAvialableOn,
                      child: Text('Pick a Date'),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Built year",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                  ),
                  Container(height: 20),

                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                    
                      onPressed: _selectDateBuitYear,
                      child: Text('Pick a Date'),
                    ),
                  ),
                ],
              ),
              Container(height: 25),
              Container(height: 0.2, color: Colors.black,),
              Container(height: 25),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/red-tree.png", scale: 3)
                    ),
              SizedBox(height: 25),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    controller.activeStep++;
                  });
                  controller.goToAddProperty7();
                },
                color: Color(0xffd92328),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              

            ],
          ),
        ),
      ),
    );
  }
}
