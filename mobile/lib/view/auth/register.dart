import 'package:client/controller/users_auth/signup_controller.dart';
import 'package:client/core/functions/validInput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  SignUpControllerImp controller = Get.put(SignUpControllerImp());
  bool loading = false;
  String passwordError = "";
  String emailError = "";
  String firstNameError = "";
  String lastNameError = "";
  String phoneError = "";
  String postalCodeError = "";

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
    controller.firstName.text = "";
    controller.lastName.text = "";
    controller.postalCode.text = "";
    controller.phoneNumber.text = "";
    controller.userRole = "Customer";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: RichText(
          text: const TextSpan(
            children: <TextSpan>[
              // TextSpan(
              //   text: "Red ",
              //   style: TextStyle(
              //     color: Color(0xffd92328),
              //     fontSize: 35,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              TextSpan(
                text: "Sign Up",
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
          : buildRegisterForm(context, controller),
    );
  }

  Widget buildRegisterForm(
      BuildContext context, SignUpControllerImp controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: controller.formstateRegister,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 20),
                const Text(
                  "First Name",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Container(height: 5),
                TextFormField(
                  validator: (val) {
                    firstNameError = validInput(val!, 2, 100, "username");
                    return firstNameError.isNotEmpty ? firstNameError : null;
                  },
                  controller: controller.firstName,
                  style: const TextStyle(),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.man),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Container(height: 22),
                const Text(
                  "Last Name",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Container(height: 5),
                TextFormField(
                  validator: (val) {
                    lastNameError = validInput(val!, 2, 100, "username");
                    return lastNameError.isNotEmpty ? lastNameError : null;
                  },
                  controller: controller.lastName,
                  style: const TextStyle(),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.man),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Container(height: 22),
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Container(height: 5),
                TextFormField(
                  validator: (val) {
                    emailError = validInput(val!, 5, 100, "email");
                    return emailError.isNotEmpty ? emailError : null;
                  },
                  controller: controller.email,
                  style: const TextStyle(),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.email),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Container(height: 22),
                const Text(
                  "Password",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Container(height: 5),
                TextFormField(
                  validator: (val) {
                    passwordError = validInput(val!, 8, 100, "password");
                    return passwordError.isNotEmpty ? passwordError : null;
                  },
                  controller: controller.password,
                  obscureText: true,
                  style: const TextStyle(),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.lock),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Container(height: 22),
                const Text(
                  "Phone Number",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Container(height: 5),
                TextFormField(
                  validator: (val) {
                    phoneError = validInput(val!, 10, 100, "phone");
                    return phoneError.isNotEmpty ? phoneError : null;
                  },
                  controller: controller.phoneNumber,
                  style: const TextStyle(),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.phone),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Container(height: 22),
                const Text(
                  "Postal Code",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Container(height: 5),
                TextFormField(
                  validator: (val) {
                    postalCodeError = validInput(val!, 4, 100, "postalCode");
                    return postalCodeError.isNotEmpty ? postalCodeError : null;
                  },
                  controller: controller.postalCode,
                  style: const TextStyle(),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.map),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Container(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: const Text(
                        "I already have an account",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Get.offNamed("/login");
                      },
                    )
                  ],
                ),
              ],
            ),
            Container(height: 20),
            MaterialButton(
              onPressed: () async {
                setState(() {});
                if (controller.formstateRegister.currentState!.validate() &&
                    controller.password.text.isNotEmpty &&
                    controller.email.text.isNotEmpty &&
                    controller.firstName.text.isNotEmpty &&
                    controller.lastName.text.isNotEmpty &&
                    controller.phoneNumber.text.isNotEmpty &&
                    controller.postalCode.text.isNotEmpty) {
                  setLoading(true);
                  await controller.signUp();
                  setLoading(false);
                }
              },
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
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
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(width: 1),
              ),
              onPressed: () {},
              color: const Color.fromARGB(255, 255, 255, 255),
              child: const Row(
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
            Container(height: 5),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(width: 1),
              ),
              onPressed: () {},
              color: const Color.fromARGB(255, 255, 255, 255),
              child: const Row(
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
            Container(height: 10),
          ],
        ),
      ),
    );
  }
}
