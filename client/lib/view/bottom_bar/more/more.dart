import 'dart:convert';
import 'package:client/main.dart';
import 'package:client/view/bottom_bar/notification/notifications_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class More extends StatefulWidget {
  More({Key? key}) : super(key: key);

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    // final visitor = sharepref!.getString("visitor") ?? "";
    String? userDtoJson = sharepref!.getString("user");
    Map<String, dynamic> userDto = json.decode(userDtoJson ?? "{}");

    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // check visitor here
                if (sharepref!.getString("user") != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(userDto["email"],
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )),
                      ),
                      MaterialButton(
                        onPressed: () {
                          sharepref!.clear();
                          print("++++++++++++++++++++++++++++++++++++++++++");
                          print(sharepref!.getString("user"));
                          Get.offAllNamed("/login");
                        },
                        child: const Text('Log out',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            )),
                      ),
                    ],
                  )
                else
                  Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const SizedBox(height: 25),
                          const Text(
                            "Welcome",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 34,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: const Text(
                              "Sign up or log in to save listings and get updates on your home search.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            onPressed: () {
                              Get.toNamed("/login");
                            },
                            minWidth: 300,
                            height: 45,
                            color: Colors.black,
                            child: const Text(
                              "Log in",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed("/register");
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "sign up",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ],
                  ),

                const Divider(
                  height: 1,
                  color: Colors.black,
                ),
                const SizedBox(height: 30),
                Container(
                  width: 360,
                  height: 45,
                  child: const Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const NotificationsSettings(),
                      ),
                    );
                  },
                  height: 55,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Notifications",
                        style: TextStyle(
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: 360,
                  height: 45,
                  child: const Text(
                    "My home",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Estimate my home value",
                        style: TextStyle(
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Sell my home",
                        style: TextStyle(
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Compare agents",
                        style: TextStyle(
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "View home equity rates",
                        style: TextStyle(
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: 360,
                  height: 45,
                  child: const Text(
                    "Buying a home",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Compare agents",
                        style: TextStyle(
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Compare agents",
                        style: TextStyle(
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Compare agents",
                        style: TextStyle(
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Compare agents",
                        style: TextStyle(
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: 360,
                  height: 45,
                  child: const Text(
                    "Rentals",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Compare agents",
                        style: TextStyle(
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Compare agents",
                        style: TextStyle(
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: 360,
                  height: 45,
                  child: const Text(
                    "Other",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Compare agents",
                        style: TextStyle(
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Compare agents",
                        style: TextStyle(
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Compare agents",
                        style: TextStyle(
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Compare agents",
                        style: TextStyle(
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Compare agents",
                        style: TextStyle(
                          color: Color.fromARGB(174, 0, 0, 0),
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 45),
                const Text("RedHouse.com® Version 23.24"),
                const Text("all copyright © rights reserved"),
                const SizedBox(height: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
