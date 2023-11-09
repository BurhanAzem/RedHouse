import 'dart:convert';
import 'package:client/controller/account_info_contoller.dart';
import 'package:client/main.dart';
import 'package:client/view/bottom_bar/more/more.dart';
import 'package:client/view/bottom_bar/notification/notifications.dart';
import 'package:client/view/bottom_bar/search/search.dart';
import 'package:client/view/contracts/all_contracts.dart';
import 'package:client/view/manage_properties/manage_properties.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  AccountInfoContoller controller =
      Get.put(AccountInfoContoller(), permanent: true);
  int _currentIndex = 0;

  final List<Icon> _selectedIcons = [
    const Icon(
      FontAwesomeIcons.magnifyingGlassLocation,
    ),
    const Icon(
      FontAwesomeIcons.solidHandshake,
    ),
    const Icon(
      FontAwesomeIcons.solidBell,
    ),
    const Icon(
      FontAwesomeIcons.house,
    ),
    const Icon(
      FontAwesomeIcons.ellipsis,
    ),
  ];

  @override
  void initState() {
    super.initState();
    controller.userDtoJson = sharepref!.getString("user");
    controller.userDto = json.decode(controller.userDtoJson ?? "{}");
    print(controller.userDtoJson);
    print(controller.userDto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          Search(),
          AllContracts(),
          Notifications(),
          ManageProperties(),
          More(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        backgroundColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 253, 45, 30),
        unselectedItemColor: Colors.grey[800],
        unselectedLabelStyle: const TextStyle(fontSize: 11.5),
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w600, fontSize: 11.5),
        items: [
          _buildBottomNavigationBarItem(0),
          _buildBottomNavigationBarItem(1),
          _buildBottomNavigationBarItem(2),
          _buildBottomNavigationBarItem(3),
          _buildBottomNavigationBarItem(4),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(int index) {
    return BottomNavigationBarItem(
      icon: _selectedIcons[index],
      label: _getLabel(index),
    );
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return "Search";
      case 1:
        return "Contracts";
      case 2:
        return "Notifications";
      case 3:
        return "Properties";
      case 4:
        return "More";
      default:
        return "";
    }
  }
}
