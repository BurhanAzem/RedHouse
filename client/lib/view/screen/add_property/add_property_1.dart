import 'package:client/controller/manage_propertise/add_property_controller.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProperty1 extends StatefulWidget {
  AddProperty1({Key? key}) : super(key: key);

  @override
  _AddProperty1State createState() => _AddProperty1State();
}

class _AddProperty1State extends State<AddProperty1> {
  // final PageController pageController;
  @override
  Widget build(BuildContext context) {
    const options = [
      "House",
      "Apartment Unit",
      "Townhouse",
      "Entire Department Community"
    ];
    AddPropertyControllerImp controller =
        Get.put(AddPropertyControllerImp(), permanent: true);
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
        padding: EdgeInsets.all(20),
        child: Form(
          key: controller.formstate,
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
                    Image.asset("assets/images/logo.png", scale:10),
                    Text(
                      "First, let's add your property",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                    ),
                  Container(height: 20),
                  Text(
                    "Street address",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(height: 5),
                  TextFormField(
                    controller: controller.streetAddress,
                    style: TextStyle(),
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.map),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Text(
                    "Enter the USPS-validated address. You won’t be able to edit the address once you create the listing.",
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500),
                  ),
                  
                ],
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                height: 300,
                child: Center(child: Text("Here is should be the map")),
              ),

              MaterialButton(
                onPressed: () {
                  setState(() {
                    controller.activeStep++;                    
                  });
                  controller.goToAddProperty2();
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
              Container(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
