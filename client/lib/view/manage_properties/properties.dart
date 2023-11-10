import 'package:client/controller/manage_propertise/add_property_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Properties extends StatelessWidget {
  const Properties({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddPropertyControllerImp controller = Get.put(AddPropertyControllerImp());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goToAddProperty1();
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 25,
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
