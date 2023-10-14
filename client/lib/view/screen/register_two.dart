import 'package:client/controller/auth/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterTwo extends StatefulWidget {
  RegisterTwo({Key? key}) : super(key: key);

  @override
  _RegisterTwoState createState() => _RegisterTwoState();
}

class _RegisterTwoState extends State<RegisterTwo> {
  final SignUpControllerImp controller = Get.find<SignUpControllerImp>();
  List<String> options = ['Customer', 'Landlord', 'Agent'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Red",
              style: TextStyle(
                color: Color(0xffd92328),
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "House",
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          child: ListView(
            children: [
              Container(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 20),
                  Text(
                    "Phone Number",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Container(height: 5),
                  TextFormField(
                    controller: controller.phoneNumber,
                    style: TextStyle(height: 0.8),
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.phone),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Container(height: 20),
                  Text(
                    "Postal Code",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Container(height: 5),
                  TextFormField(
                    controller: controller.postalCode,
                    style: TextStyle(),
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.map),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Container(height: 20),
                  Text(
                    "User Role",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Container(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButton<String>(
                      value: controller.userRole,
                      items: options.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            controller.userRole = newValue;
                          });
                        }
                      },
                      isExpanded: true,
                      underline: SizedBox(),
                    ),
                  ),
                  Container(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("I already have an account"),
                    ],
                  ),
                ],
              ),
              Container(height: 20),
              MaterialButton(
                onPressed: () {
                  controller.signUp();
                },
                color: Color(0xffd92328),
                child: Text(
                  "Sign Up",
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
              Container(
                child: Text(
                  "or",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(height: 15),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 1),
                ),
                onPressed: () {},
                color: Color.fromARGB(255, 255, 255, 255),
                child: Row(
                  children: [
                    Icon(Icons.email),
                    Text(
                      "                 Continue with Google",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 15),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 1),
                ),
                onPressed: () {},
                color: Color.fromARGB(255, 255, 255, 255),
                child: Row(
                  children: [
                    Icon(Icons.facebook),
                    Text(
                      "                  Continue with Facebook",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
