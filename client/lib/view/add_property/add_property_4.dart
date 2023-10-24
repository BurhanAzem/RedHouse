
import 'package:client/controller/manage_propertise/add_property_controller.dart';
import 'package:client/view/firebase.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AddProperty4 extends StatefulWidget {
  AddProperty4({Key? key}) : super(key: key);

  @override
  _AddProperty4State createState() => _AddProperty4State();
}

class _AddProperty4State extends State<AddProperty4> {
  // final PageController pageController;
  @override
  Widget build(BuildContext context) {
    const options = [
      "City",
      "Mountain",
      "Water",
    ];
    const optionBool = [
      "Yes",
      "No"
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
                    "How much is the monthly rent?",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                  ),
                  Container(height: 20),
                  Text(
                    "Property price",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(height: 5),
                  Container(
                    child: TextFormField(
                      controller: controller.price,
                      style: TextStyle(),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.money),
                        hintText: "Example: 2000",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(height: 20),
                  Text(
                    "Parking Spots",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(height: 5),
                  Container(
                    child: TextFormField(
                      controller: controller.parkingSpots,
                      style: TextStyle(),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.numbers),
                        hintText: "Example: 3",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(height: 20),
                  Text(
                    "Is Avaliable Basement",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButton<String>(
                      value: controller.isAvaliableBasement,
                      items: optionBool.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            controller.isAvaliableBasement = newValue;
                          });
                        }
                      },
                      isExpanded: true,
                      underline: SizedBox(),
                    ),
                  ),
                  Container(height: 20),
                  Text(
                    "Property view",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButton<String>(
                      value: controller.view,
                      items: options.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            controller.view = newValue;
                          });
                        }
                      },
                      isExpanded: true,
                      underline: SizedBox(),
                    ),
                  ),
                ],
              ),
              Container(height: 25),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    controller.activeStep++;                    
                  });
                  controller.goToAddProperty5();
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
