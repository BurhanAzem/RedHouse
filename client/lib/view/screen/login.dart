import 'package:client/controller/auth/login_controller.dart';
import 'package:client/core/functions/validInput.dart';
import 'package:client/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginControllerImp controller = Get.put(LoginControllerImp());
    bool visitor = false;

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
          key: controller.formstate,
          child: ListView(
            children: [
              Text(
                "Login with your email and password\n or continue with social media",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              Container(height: 60),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Container(height: 5),
                  TextFormField(
                    validator: (val) {
                      return validInput(val!, 5, 100, "email");
                    },
                    controller: controller.email,
                    style: TextStyle(),
                    decoration: InputDecoration(
                      suffixIcon:
                          Icon(Icons.email), // Use prefixIcon for email icon
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
                    validator: (val) {
                      return validInput(val!, 5, 30, "password");
                    },
                    controller: controller.password,
                    style: TextStyle(),
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
                  Container(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Text("Don't have an account ?"),
                        onTap: () {
                          controller.goToSignUp();
                        },
                      ),
                      InkWell(
                          child: Text(
                              "Forgot password")) // Corrected "Forget" to "Forgot"
                    ],
                  ),
                ],
              ),
              Container(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  controller.login();
                },
                color: Color(0xffd92328),
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ), // Provide a child for the bu),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                height: 15,
              ),
              MaterialButton(
                onPressed: () {
                  visitor = true;
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => BottomBar(visitor),
                    ),
                    (route) =>
                        false, // This predicate ensures all routes are removed
                  );
                },
                color: Color.fromARGB(255, 255, 255, 255),
                child: Text(
                  "Login as visitor",
                  style: TextStyle(
                      color: Color(0xffd92328), fontWeight: FontWeight.w700),
                ), // Provide a child for the bu),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 1)),
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
                      "                  Continue with Google",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Container(
                height: 15,
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
                      "                  Continue with Facebook",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
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
