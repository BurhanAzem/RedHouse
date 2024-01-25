import 'package:client/controller/users_auth/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RegisterType extends StatefulWidget {
  RegisterType({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterTypeState createState() => _RegisterTypeState();
}

class _RegisterTypeState extends State<RegisterType> {
  SignUpControllerImp controller =
      Get.put(SignUpControllerImp(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffc299),
      // backgroundColor: const Color.fromARGB(255, 220, 219, 219),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  SizedBox(height: 200),
                  Text(
                    "The basic account is concerned with selling or renting its own real estate, or buying or renting the real estate of others",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17.5,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "The judicial lawyer is responsible for following up the contracts that take place between users",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17.5,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 230,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                color: Colors.white,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),
                    MaterialButton(
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(width: 1),
                      ),
                      onPressed: () {
                        controller.userRole = "basic account";
                      },
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: const Row(
                        children: [
                          Icon(FontAwesomeIcons.solidUser),
                          SizedBox(width: 40),
                          Text(
                            "Register as basic account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 20),
                    MaterialButton(
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(width: 1),
                      ),
                      onPressed: () {
                        controller.userRole = "lawyer";
                      },
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: const Row(
                        children: [
                          Icon(FontAwesomeIcons.userGraduate),
                          SizedBox(width: 40),
                          Text(
                            "Register as judicial lawyer",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
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
        ],
      ),
    );
  }
}
