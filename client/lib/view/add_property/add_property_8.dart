import 'package:client/controller/bottom_bar/bottom_bar.dart';
import 'package:client/controller/manage_propertise/manage_property_controller.dart';
import 'package:client/view/bottom_bar/bottom_bar.dart';
import 'package:client/view/more/my_properties.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProperty8 extends StatefulWidget {
  AddProperty8({Key? key}) : super(key: key);

  @override
  _AddProperty8State createState() => _AddProperty8State();
}

class _AddProperty8State extends State<AddProperty8> {
  @override
  Widget build(BuildContext context) {
    final List<String> optionsStatus = [
      "Coming soon",
      "Accepting offers",
      // "Under contract"
    ];
    final List<String> options = ["Landlord", "Agent"];

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
              "Property Status",
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
                      Container(height: 20),
                      const Text(
                        "Property status",
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
                              controller.propertyStatus =
                                  controller.propertyStatus;
                            });
                          },
                          isExpanded: true,
                          underline: const SizedBox(),
                        ),
                      ),
                      Container(height: 20),
                      const Text(
                        "Listing by",
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
                          underline: const SizedBox(),
                        ),
                      ),
                      Container(height: 5),
                      Container(
                          alignment: Alignment.center,
                          child: Image.asset("assets/images/red-tree.png",
                              scale: 3)),
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
                      setState(() {});
                      ScaffoldMessenger.of(context).clearSnackBars();
                      SnackBar snackBar = const SnackBar(
                        content: Text("Added Successfully"),
                        backgroundColor: Colors.blue,
                      );

                      showDialog(
                        context: context,
                        builder: (context) {
                          // Show a loading dialog while processing
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );

                      BottomBarController bottomBarController =
                          Get.put(BottomBarController(), permanent: true);

                      // AddPropertyFuture is a function that performs controller.AddProperty
                      Future<void> addPropertyFuture() async {
                        await controller.AddProperty();

                        print(bottomBarController.currentIndex);
                        if (bottomBarController.currentIndex == 3) {
                          Get.offAll(() => BottomBar());
                        } else if (bottomBarController.currentIndex == 4) {
                          Get.offAll(() => BottomBar());
                          Get.to(() => MyProperties());
                        }

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                      // Execute the addPropertyFuture asynchronously and navigate when done
                      addPropertyFuture();
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
      },
    );
  }
}
