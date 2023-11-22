import 'package:client/controller/manage_propertise/manage_property_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProperty2 extends StatefulWidget {
  AddProperty2({Key? key}) : super(key: key);

  @override
  _AddProperty2State createState() => _AddProperty2State();
}

class _AddProperty2State extends State<AddProperty2> {
  @override
  Widget build(BuildContext context) {
    const options = [
      "House",
      "Apartment Unit",
      "Townhouse",
      "Castle",
      "Entire Department Community"
    ];

    return GetBuilder<ManagePropertyControllerImp>(
      init: ManagePropertyControllerImp(),
      builder: (ManagePropertyControllerImp controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  controller.decreaseActiveStep();
                  print(controller.activeStep);
                  Navigator.pop(context);
                });
              },
            ),
            title: const Text(
              "Property Type",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
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
                      controller.easyStepper(),
                      Image.asset("assets/images/logo.png", scale: 10),
                      const Text(
                        "Let's continue",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 23),
                      ),
                      Container(height: 20),
                      const Text(
                        "Property type",
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
                          value: controller.propertyType,
                          items: options.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                controller.propertyType = newValue;
                              });
                            }
                          },
                          isExpanded: true,
                          underline: const SizedBox(),
                        ),
                      ),
                      Container(height: 25),
                      const Row(
                        children: [
                          Text(
                            "Number of units",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            " (if needed)",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
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
                      Container(height: 20),
                      const Text(
                        "Listing type",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Column(
                        children: [
                          RadioListTile(
                            title: const Text("For rent"),
                            value: "For rent",
                            groupValue: controller.listingType,
                            onChanged: (value) {
                              setState(() {
                                controller.listingType = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: const Text("For sell"),
                            value: "For sell",
                            groupValue: controller.listingType,
                            onChanged: (value) {
                              setState(() {
                                controller.listingType = value.toString();
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(height: 70),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        controller.increaseActiveStep();
                        print(controller.activeStep);
                      });
                      controller.goToAddProperty3();
                    },
                    color: const Color(0xffd92328),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Continue",
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
      },
    );
  }
}
