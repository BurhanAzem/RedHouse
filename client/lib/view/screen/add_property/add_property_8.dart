import 'package:client/controller/manage_propertise/add_property_controller.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProperty8 extends StatefulWidget {
  AddProperty8({Key? key}) : super(key: key);

  @override
  _AddProperty8State createState() => _AddProperty8State();
}

class _AddProperty8State extends State<AddProperty8> {
  // final PageController pageController;
  @override
  Widget build(BuildContext context) {
    final List<String> optionsStatus = [
      "Coming soon",
      "Accepting offers",
      "Under contract"
    ];
    final List<String> options = ["Landlord", "Agent"];

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
                            backgroundColor: controller.activeStep >= 0
                                ? Color(0xffd92328)
                                : Colors.grey,
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
                            backgroundColor: controller.activeStep >= 1
                                ? Color(0xffd92328)
                                : Colors.grey,
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
                            backgroundColor: controller.activeStep >= 2
                                ? Color(0xffd92328)
                                : Colors.grey,
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
                            backgroundColor: controller.activeStep >= 3
                                ? Color(0xffd92328)
                                : Colors.grey,
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
                            backgroundColor: controller.activeStep >= 4
                                ? Color(0xffd92328)
                                : Colors.grey,
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
                            backgroundColor: controller.activeStep >= 5
                                ? Color(0xffd92328)
                                : Colors.grey,
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
                            backgroundColor: controller.activeStep >= 6
                                ? Color(0xffd92328)
                                : Colors.grey,
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
                            backgroundColor: controller.activeStep >= 7
                                ? Color(0xffd92328)
                                : Colors.grey,
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
                            backgroundColor: controller.activeStep >= 8
                                ? Color(0xffd92328)
                                : Colors.grey,
                          ),
                        ),
                        // title: 'Delivered',
                      ),
                    ],
                    onStepReached: (index) =>
                        setState(() => controller.activeStep = index),
                  ),
                  Image.asset("assets/images/logo.png", scale: 10),
                  Container(height: 20),
                  Text(
                    "Property status",
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
                      value: controller.propertyStatus,
                      items: optionsStatus.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          controller.propertyStatus = newValue ?? "";
                          // Update the controller's property here.
                          controller.propertyStatus = controller.propertyStatus;
                        });
                      },
                      isExpanded: true,
                      underline: SizedBox(),
                    ),
                  ),
                  Container(height: 20),
                  Text(
                    "Listing by",
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
                      value: controller.listingBy,
                      items: options.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          controller.listingBy = newValue ?? "";
                          // Update the controller's property here.
                          controller.listingBy = controller.listingBy;
                        });
                      },
                      isExpanded: true,
                      underline: SizedBox(),
                    ),
                  ),
                  Container(height: 5),
                  Container(
                      alignment: Alignment.center,
                      child:
                          Image.asset("assets/images/red-tree.png", scale: 3)),
                ],
              ),
              Container(height: 25),
              Text(
                "Please note you can not edit property dat again",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500),
              ),
              Container(height: 5),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    controller.activeStep++;
                  });
                  controller.AddProperty();
                },
                color: Color(0xffd92328),
                child: Text(
                  "Save property",
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
