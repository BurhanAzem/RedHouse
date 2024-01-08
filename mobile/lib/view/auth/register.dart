import 'package:client/controller/users_auth/signup_controller.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  SignUpControllerImp controller = Get.put(SignUpControllerImp());
  List<String> options = ['Customer', 'Landlord', 'Agent'];
  bool loading = false;

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
                Container(height: 22),
                const Text(
                  "User Role",
                  style: TextStyle(fontSize: 18, color: Colors.black),
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
                    underline: const SizedBox(),
                  ),
                ),
                Container(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: const Text("I already have an account"),
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
                setLoading(true);
                await controller.signUp();
                setLoading(false);
              },
              color: const Color(0xffd92328),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.black,
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
                borderRadius: BorderRadius.circular(10),
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
                borderRadius: BorderRadius.circular(10),
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
