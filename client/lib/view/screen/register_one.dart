import 'package:client/controller/auth/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class RegisterOne extends StatelessWidget {
   const RegisterOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   SignUpControllerImp controller = Get.put(SignUpControllerImp());

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
          key: controller.formstateRegister,
          child: ListView(
            children: [
              Container(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 20),
                    Text(
                      "First Name",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Container(height: 5),
                    TextFormField(
                      controller: controller.firstName,
                      style: TextStyle(height: 0.8),
                      decoration: InputDecoration(
                        suffixIcon:
                            Icon(Icons.man), // Use prefixIcon for password icon
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Container(height: 20),
                        Text(
                          "Last Name",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Container(height: 5),
                        TextFormField(
                          controller: controller.lastName,
                          style: TextStyle(),
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                                Icons.man), // Use prefixIcon for email icon
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: EdgeInsets.all(5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      
                    Container(height: 20),
                    Text(
                      "Email",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Container(height: 5),
                    TextFormField(
                      controller: controller.email,
                      style: TextStyle(height: 0.8),
                      decoration: InputDecoration(
                        suffixIcon:
                            Icon(Icons.email), // Use prefixIcon for password icon
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Container(height: 20),
                    Text(
                      "Password",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Container(height: 5),
                    TextFormField(
                      controller: controller.password,
                      style: TextStyle(height: 0.8),
                      decoration: InputDecoration(
                        suffixIcon:
                            Icon(Icons.lock), // Use prefixIcon for password icon
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Container(height: 20),
                    Container(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(child: Text("I already have an account"),
                        onTap: () {
                          controller.goToLogin();
                        },
                        )
                      ],
                    ),
                  ],
                ),
              Container(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  controller.goToRegisterTwo();
                },
                color: Color(0xffd92328),
                child: Text(
                  "Next",
                  style:
                      TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                ), // Provide a child for the bu),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                height: 15,
              ),
              Container(
                  child: Text(
                "or",
                textAlign: TextAlign.center,
              )),
              Container(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(width: 1)),
                    onPressed: () {},
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Row(
                      children: [
                        Icon(Icons.email),
                        Text(
                          "      Google             ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(width: 1)),
                    onPressed: () {},
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Row(
                      children: [
                        Icon(Icons.facebook),
                        Text(
                          " Facebook              ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
