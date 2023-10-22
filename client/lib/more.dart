import 'package:client/notifications_settings.dart';
import 'package:client/view/screen/login.dart';
import 'package:client/view/screen/register_one.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class More extends StatefulWidget {
  bool visitor;
  More({Key? key, required this.visitor}) : super(key: key);

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // check visitor here
                if (widget.visitor)
                  Column(
                    children: <Widget>[
                      SizedBox(height: 25),
                      Text(
                        "Welcome",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 34,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "Sign up or log in to save listings and get updates on your home search.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        minWidth: 300,
                        height: 45,
                        color: Colors.black,
                        child: Text(
                          "Log in",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => RegisterOne()),
                          );
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
                      SizedBox(height: 30),
                    ],
                  ),
                if (!widget.visitor)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('ayman.dwikat.2001@gmail.com',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            widget.visitor = true;
                          });
                        },
                        child: Text('Log out',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            )),
                      ),
                    ],
                  ),
                Divider(
                  height: 1,
                  color: Colors.black,
                ),
                SizedBox(height: 30),
                Container(
                  width: 360,
                  height: 45,
                  child: const Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NotificationsSettings(),
                      ),
                    );
                  },
                  height: 55,
                  child: Row(
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
                SizedBox(height: 40),
                Container(
                  width: 360,
                  height: 45,
                  child: Text(
                    "My home",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: Row(
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
                  child: Row(
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
                  child: Row(
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
                  child: Row(
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
                SizedBox(height: 40),
                Container(
                  width: 360,
                  height: 45,
                  child: Text(
                    "Buying a home",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: Row(
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
                  child: Row(
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
                  child: Row(
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
                  child: Row(
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
                SizedBox(height: 40),
                Container(
                  width: 360,
                  height: 45,
                  child: Text(
                    "Rentals",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: Row(
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
                  child: Row(
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
                SizedBox(height: 40),
                Container(
                  width: 360,
                  height: 45,
                  child: Text(
                    "Other",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  child: Row(
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
                  child: Row(
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
                  child: Row(
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
                  child: Row(
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
                  child: Row(
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
                SizedBox(height: 45),
                Text("RedHouse.com® Version 23.24"),
                Text("all copyright © rights reserved"),
                SizedBox(height: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
