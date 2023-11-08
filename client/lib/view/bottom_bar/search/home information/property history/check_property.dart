import 'package:client/controller/account_info_contoller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CheckProperty extends StatelessWidget {
  const CheckProperty({super.key});

  @override
  Widget build(BuildContext context) {
    AccountInfoContoller controller = Get.put(AccountInfoContoller());

    String getShortenedName(String? name) {
      if (name != null) {
        final nameParts = name.split(' ');
        if (nameParts.length == 2) {
          return nameParts[0].substring(0, 1) + nameParts[1].substring(0, 1);
        } else if (nameParts.length == 1) {
          return nameParts[0].substring(0, 1);
        }
      }
      return "";
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(0, 153, 115, 1),
              ),
              child: Center(
                child: Icon(
                  FontAwesomeIcons.house,
                  size: 35,
                  color: Colors.grey[100],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Property",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 15),
            TabBar(
              tabs: const [
                Tab(text: 'Feedback'),
                Tab(text: 'History'),
              ],
              overlayColor: MaterialStatePropertyAll(Colors.grey[350]),
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
            const Expanded(
              child: TabBarView(
                children: [
                  Text("Feedback"),
                  Text("History"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
