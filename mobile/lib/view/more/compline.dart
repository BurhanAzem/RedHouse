import 'package:flutter/material.dart';

class Compline extends StatelessWidget {
  const Compline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Send complaint",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              // key: controller.formstate,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 5),
                  TextFormField(
                    validator: (val) {
                      // return validInput(val!, 5, 100, "email");
                    },
                    // controller: controller.email,
                    style: const TextStyle(),
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.email),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Container(height: 15),
                  const Row(
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                  Container(height: 5),
                  TextFormField(
                    validator: (val) {
                      // return validInput(val!, 5, 30, "password");
                    },
                    // controller: controller.password,
                    obscureText: true,
                    style: const TextStyle(),
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.email),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Container(height: 15),
                  const Row(
                    children: [
                      Text(
                        "Compline description",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 5),
                  Container(
                    child: TextFormField(
                      minLines: 10,
                      maxLines: 20,
                      // controller: controller.propertyDescription,
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
                  Container(height: 30),
                  Container(
                    width: 340,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {},
                      minWidth: 300,
                      height: 45,
                      color: Colors.black87,
                      child: const Center(
                        child: Text(
                          "Send",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
