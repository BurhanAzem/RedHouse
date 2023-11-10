import 'package:client/controller/manage_propertise/manage_property_controller.dart';
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
      "Any",
      "City",
      "Village",
      "Mountain",
      "Beach",
      "Island",
    ];
    const optionBool = ["Yes", "No"];
    ManagePropertyControllerImp controller =
        Get.put(ManagePropertyControllerImp(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        title: const Row(
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
        padding: const EdgeInsets.all(20),
        child: Form(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EasyStepper(
                    finishedStepBackgroundColor: const Color(0xffd92328),
                    activeStepBorderColor: Colors.black,
                    stepShape: StepShape.circle,
                    lineStyle: const LineStyle(),

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
                                ? const Color(0xffd92328)
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
                                ? const Color(0xffd92328)
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
                                ? const Color(0xffd92328)
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
                                ? const Color(0xffd92328)
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
                                ? const Color(0xffd92328)
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
                                ? const Color(0xffd92328)
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
                                ? const Color(0xffd92328)
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
                                ? const Color(0xffd92328)
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
                                ? const Color(0xffd92328)
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
                  Container(height: 5),
                  const Text(
                    "How much is the monthly rent?",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                  ),
                  Container(height: 20),
                  const Text(
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
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.money),
                        hintText: "Example: 2000",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(height: 20),
                  const Text(
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
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.numbers),
                        hintText: "Example: 3",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(height: 20),
                  const Text(
                    "Is Avaliable Basement",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      underline: const SizedBox(),
                    ),
                  ),
                  Container(height: 20),
                  const Text(
                    "Property view",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      underline: const SizedBox(),
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
                color: const Color(0xffd92328),
                child: const Text(
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
