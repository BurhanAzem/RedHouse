import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/main.dart';
import 'package:client/view/messages/messages_page.dart';
import 'package:client/view/more/account_information.dart';
import 'package:client/view/more/favorite_properties.dart';
import 'package:client/view/more/my_feedback.dart';
import 'package:client/view/more/my_properties.dart';
import 'package:client/view/notification/notifications_settings.dart';
import 'package:client/view/offers/all_offers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  LoginControllerImp loginController = Get.put(LoginControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Here check visitor or No
          if (sharepref.getString("user") != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: () {
                      if (loginController.userDto != null) {
                        Get.to(() => const AccountInformation());
                      }
                    },
                    child: Text(loginController.userDto?["email"] ?? "",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        )),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    sharepref.clear();
                    Get.offAllNamed("/login");
                  },
                  child: const Text('Log out',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
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
                      padding: const EdgeInsets.symmetric(horizontal: 30),
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

          // Line and Space
          const Divider(
            height: 1,
            color: Colors.black,
          ),
          const SizedBox(height: 20),

          // Here settings list
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: const Text(
              "Settings",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 27,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              child: const Text(
                "Profile",
                style: TextStyle(
                  color: Color.fromARGB(174, 0, 0, 0),
                  fontSize: 19,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const NotificationsSettings());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              child: const Text(
                "Notifications",
                style: TextStyle(
                  color: Color.fromARGB(174, 0, 0, 0),
                  fontSize: 19,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),

          // Here home list
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: const Text(
              "My home",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 27,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const Messages());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              child: const Text(
                "Messages",
                style: TextStyle(
                  color: Color.fromARGB(174, 0, 0, 0),
                  fontSize: 19,
                ),
              ),
            ),
          ),
          
          InkWell(
            onTap: () {
              Get.to(() => const MyProperties());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              child: const Text(
                "Properties",
                style: TextStyle(
                  color: Color.fromARGB(174, 0, 0, 0),
                  fontSize: 19,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const MyFeedback());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              child: const Text(
                "Feedback",
                style: TextStyle(
                  color: Color.fromARGB(174, 0, 0, 0),
                  fontSize: 19,
                ),
              ),
            ),
          ),InkWell(
            onTap: () {
              Get.to(() => const AllOffers());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              child: const Text(
                "Offers",
                style: TextStyle(
                  color: Color.fromARGB(174, 0, 0, 0),
                  fontSize: 19,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => FavoriteProperties());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              child: const Text(
                "Favorite properties",
                style: TextStyle(
                  color: Color.fromARGB(174, 0, 0, 0),
                  fontSize: 19,
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // here buying a home list
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: const Text(
              "Buying a home",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 27,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              child: const Text(
                "x1",
                style: TextStyle(
                  color: Color.fromARGB(174, 0, 0, 0),
                  fontSize: 19,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const NotificationsSettings());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              child: const Text(
                "x2",
                style: TextStyle(
                  color: Color.fromARGB(174, 0, 0, 0),
                  fontSize: 19,
                ),
              ),
            ),
          ),

          // here the end
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("RedHouse.com® Version 23.24"),
                Text("all copyright © rights reserved"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
