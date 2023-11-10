import 'package:client/controller/manage_propertise/manage_property_controller.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProperty9 extends StatefulWidget {
  AddProperty9({Key? key}) : super(key: key);

  @override
  _AddProperty9State createState() => _AddProperty9State();
}

class _AddProperty9State extends State<AddProperty9> {
  // final PageController pageController;
  @override
  Widget build(BuildContext context) {
    const options = [
      "House",
      "Apartment Unit",
      "Castel",
      "Townhouse",
      "Entire Department Community"
    ];
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
                    "Let's start creating your property",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                  ),
                  Container(height: 20),
                  const Text(
                    "Square meter",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(height: 5),
                  TextFormField(
                    controller: controller.squareMeter,
                    style: const TextStyle(),
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.square_foot),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Container(height: 25),
                  const Text(
                    "Total bedrooms",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    controller: controller.numberOfUnits,
                    style: const TextStyle(height: 0.8),
                    decoration: InputDecoration(
                      hintText: "",
                      suffixIcon: const Icon(Icons.numbers),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Container(height: 25),
                  const Text(
                    "Total bathrooms",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    controller: controller.numberOfUnits,
                    style: const TextStyle(height: 0.8),
                    decoration: InputDecoration(
                      hintText: "",
                      suffixIcon: const Icon(Icons.numbers),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
              MaterialButton(
                onPressed: () {
                  controller.AddProperty();
                },
                color: const Color(0xffd92328),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Save property",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
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
