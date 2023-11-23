import 'package:client/controller/manage_propertise/manage_property_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProperty5 extends StatefulWidget {
  AddProperty5({Key? key}) : super(key: key);

  @override
  _AddProperty5State createState() => _AddProperty5State();
}

class _AddProperty5State extends State<AddProperty5> {
  @override
  Widget build(BuildContext context) {
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
              "Property Location",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
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
                        "Let's start creating your property",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 23),
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
                        controller: controller.numberOfBedrooms,
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
                        controller: controller.numberOfBathrooms,
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
                    ],
                  ),
                  Container(height: 25),
                  Container(
                      alignment: Alignment.center,
                      child:
                          Image.asset("assets/images/red-tree.png", scale: 3)),
                  const SizedBox(height: 25),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        controller.increaseActiveStep();
                        print(controller.activeStep);
                      });
                      controller.goToAddProperty6();
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
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
