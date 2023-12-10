import 'package:client/controller/manage_propertise/manage_properties_controller.dart';
import 'package:client/view/add_property/add_property_4.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProperty3 extends StatefulWidget {
  AddProperty3({Key? key}) : super(key: key);

  @override
  _AddProperty3State createState() => _AddProperty3State();
}

class _AddProperty3State extends State<AddProperty3> {
  @override
  Widget build(BuildContext context) {
    const options = [
      "House",
      "Apartment Unit",
      "Townhouse",
      "Castel",
      "Entire Department Community",
    ];

    return GetBuilder<ManagePropertiesController>(
      init: ManagePropertiesController(),
      builder: (ManagePropertiesController controller) {
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
              "Property Description",
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
                      Container(height: 5),
                      const Text(
                        "Describe the property",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 23),
                      ),
                      Container(height: 5),
                      const Text(
                        "Write several sentences describing the upgrades and desirable features that will attract renters to your property.",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                      Container(height: 20),
                      const Text(
                        "Property description",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(height: 5),
                      Container(
                        child: TextFormField(
                          minLines: 7,
                          maxLines: 10,
                          controller: controller.propertyDescription,
                          style: const TextStyle(),
                          decoration: InputDecoration(
                            // suffixIcon: Icon(Icons.description),
                            hintText:
                                "Example: New house in the center of the city, there is close school and very beautiful view",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: const EdgeInsets.all(5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      // Container(height: 5),
                      // Container(
                      //   alignment: Alignment.center,
                      //   child:
                      //       Image.asset("assets/images/red-tree.png", scale: 3),
                      // ),
                    ],
                  ),
                  Container(height: 25),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        controller.increaseActiveStep();
                        print(controller.activeStep);
                      });
                      Get.to(() => AddProperty4());
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
