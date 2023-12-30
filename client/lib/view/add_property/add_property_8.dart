import 'package:client/controller/bottom_bar/bottom_bar.dart';
import 'package:client/controller/manage_propertise/manage_properties_controller.dart';
import 'package:client/view/bottom_bar/bottom_bar.dart';
import 'package:client/view/more/my_properties.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProperty8 extends StatefulWidget {
  AddProperty8({Key? key}) : super(key: key);

  @override
  _AddProperty8State createState() => _AddProperty8State();
}

class _AddProperty8State extends State<AddProperty8>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _textAnimation;

  @override
  void initState() {
    // Initialize AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    // Create a Tween for the animation
    _textAnimation = IntTween(
            begin: 0, end: "Enter more information about your property".length)
        .animate(_animationController);

    // Start the animation
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> options = ["Landlord", "Agent"];

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
              "Add Property",
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                        await controller.addProperty();

                        print(bottomBarController.currentIndex);
                        if (bottomBarController.currentIndex == 3) {
                          Get.offAll(() => const BottomBar());
                        } else if (bottomBarController.currentIndex == 4) {
                          Get.offAll(() => const BottomBar());
                          Get.to(() => const MyProperties());
                        }

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                      // Execute the addPropertyFuture asynchronously and navigate when done
                      addPropertyFuture();
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Body
          body: ListView(
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling
            children: [
              controller.easyStepper(),
              Container(
                margin: const EdgeInsets.only(right: 15, left: 15, bottom: 25),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Introduction
                      Image.asset("assets/images/logo.png", scale: 11),
                      Container(
                        child: AnimatedBuilder(
                          animation: _textAnimation,
                          builder: (context, child) {
                            String animatedText =
                                "Enter more information about your property"
                                    .substring(0, _textAnimation.value);
                            return Text(
                              animatedText,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            );
                          },
                        ),
                      ),

                      // listing By
                      Container(height: 25),
                      const Text(
                        "Listing by",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
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
                              controller.listingBy = controller.listingBy;
                            });
                          },
                          isExpanded: true,
                          underline: const SizedBox(),
                        ),
                      ),

                      // Image
                      Container(height: 40),
                      Container(
                        height: 1.5,
                        color: Colors.black38,
                      ),
                      // Container(height: 5),
                      Container(
                        alignment: Alignment.center,
                        child:
                            Image.asset("assets/images/red-tree.png", scale: 2),
                      ),
                      Container(height: 15),
                      Container(
                        height: 1.5,
                        color: Colors.black38,
                      ),
                      Container(height: 35),

                      // button
                      MaterialButton(
                        minWidth: 500,
                        height: 44,
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
                            await controller.addProperty();

                            print(bottomBarController.currentIndex);
                            if (bottomBarController.currentIndex == 3) {
                              Get.offAll(() => const BottomBar());
                            } else if (bottomBarController.currentIndex == 4) {
                              Get.offAll(() => const BottomBar());
                              Get.to(() => const MyProperties());
                            }

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }

                          // Execute the addPropertyFuture asynchronously and navigate when done
                          addPropertyFuture();
                        },
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Save your property",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
