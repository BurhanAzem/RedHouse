import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/core/functions/validInput.dart';
import 'package:client/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  Login({
    Key? key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  LoginControllerImp controller = Get.put(LoginControllerImp());

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  void initState() {
    super.initState();
    controller.email.text = "";
    controller.password.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: RichText(
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "Red ",
                style: TextStyle(
                  color: Color(0xffd92328),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "House",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : buildLoginForm(context, controller),
    );
  }

  Widget buildLoginForm(BuildContext context, LoginControllerImp controller) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.formstate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login with your email and password\n or continue with social media",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(height: 35),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Email",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Container(height: 5),
                    TextFormField(
                      validator: (val) {
                        return validInput(val!, 5, 100, "email");
                      },
                      controller: controller.email,
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
                    Container(height: 20),
                    const Text(
                      "Password",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Container(height: 5),
                    TextFormField(
                      validator: (val) {
                        return validInput(val!, 5, 30, "password");
                      },
                      controller: controller.password,
                      obscureText: true,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.lock),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.all(5),
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
                          child: const Text("Don't have an account?"),
                          onTap: () {
                            Get.offNamed("/register");
                          },
                        ),
                        const InkWell(
                          child: Text("Forgot password"),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () async {
                    setLoading(true);
                    await controller.login();
                    setLoading(false);
                  },
                  color: const Color(0xffd92328),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 10),
                MaterialButton(
                  onPressed: () async {
                    Get.offAllNamed("/bottom-bar");
                  },
                  color: const Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(width: 1),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login as visitor",
                        style: TextStyle(
                          color: Color(0xffd92328),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 15),
                Container(
                  child: const Text(
                    "or",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(height: 15),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(width: 1),
                  ),
                  onPressed: () {},
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: const Row(
                    children: [
                      Icon(Icons.email),
                      SizedBox(width: 55),
                      Text(
                        "Continue with Google",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 10),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(width: 1),
                  ),
                  onPressed: () {},
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: const Row(
                    children: [
                      Icon(Icons.facebook),
                      SizedBox(width: 55),
                      Text(
                        "Continue with Facebook",
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
      ),
    );
  }
}
