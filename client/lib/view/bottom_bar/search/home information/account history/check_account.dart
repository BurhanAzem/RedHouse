import 'package:client/controller/account_info_contoller.dart';
import 'package:client/view/bottom_bar/search/home%20information/account%20history/account_feedback.dart';
import 'package:client/view/bottom_bar/search/home%20information/account%20history/account_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckAccount extends StatefulWidget {
  const CheckAccount({Key? key});

  @override
  State<CheckAccount> createState() => _CheckAccountState();
}

class _CheckAccountState extends State<CheckAccount> {
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    AccountInfoContoller controller = Get.put(AccountInfoContoller());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 27),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 3),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 100),
                Column(
                  children: [
                    const SizedBox(height: 15),
                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(0, 153, 115, 1),
                      ),
                      child: Center(
                        child: Text(
                          controller
                              .getShortenedName(controller.userDto?["name"]),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              controller.userDto?["name"] ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              controller.userDto?["email"] ?? "",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  isFollowed = !isFollowed;
                });
              },
              child: Container(
                width: 140,
                height: 38,
                decoration: BoxDecoration(
                  color: isFollowed ? Colors.grey[300] : Colors.blue,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isFollowed) const SizedBox(width: 10),
                    Text(
                      isFollowed ? "Followed" : "Follow",
                      style: TextStyle(
                        fontSize: 16,
                        color: isFollowed ? Colors.black : Colors.white,
                      ),
                    ),
                    if (isFollowed)
                      const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.black,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            TabBar(
              tabs: const [
                Tab(text: 'Feedback'),
                Tab(text: 'History'),
              ],
              overlayColor: MaterialStateProperty.all(Colors.grey[350]),
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
              unselectedLabelColor: Colors.grey[700],
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 17,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FeedbackWidget(),
                  HistoryWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
