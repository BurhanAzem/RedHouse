import 'dart:convert';

import 'package:client/controller/manage_propertise/manage_property_controller.dart';
import 'package:client/main.dart';
import 'package:client/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Properties extends StatefulWidget {
  const Properties({Key? key}) : super(key: key);
  @override
  _AllPropertiesState createState() => _AllPropertiesState();
}

class _AllPropertiesState extends State<Properties> {
  bool isLoading = true; // Add a boolean variable for loading state

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  late ManagePropertyControllerImp controller;
  void loadData() async {
    controller = Get.put(ManagePropertyControllerImp());
    String? userDtoJson = sharepref!.getString("user");
    Map<String, dynamic> userDto = json.decode(userDtoJson ?? "{}");
    User user = User.fromJson(userDto);

    controller.propertiesUserId = user.id;
    await controller.getPropertiesUser();

    setState(() {
      isLoading = false; // Set isLoading to false when data is loaded
    });
  }

  // Check if data is still loading

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goToAddProperty1();
        },
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
        child: const Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Set the number of items you want in the list
              itemBuilder: (context, index) {
                // Replace this with the actual content for each list item
                return Card(
                  elevation: 5, // Add a shadow to the card
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Padding(
                    padding:
                        const EdgeInsets.all(16.0), // Add padding for spacing
                    child: Text(
                      "Property $index",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 1, 1),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
