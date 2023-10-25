import 'package:client/view/bottom_bar/more/more.dart';
import 'package:client/view/bottom_bar/myhome/myhome.dart';
import 'package:client/view/bottom_bar/mylistings/mylistings.dart';
import 'package:client/view/bottom_bar/notification/notifications.dart';
import 'package:client/view/bottom_bar/search/search.dart';
import 'package:client/view/manage_properties/manage_properties.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBar extends StatefulWidget {
  BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  List<Icon> _unselectedIcons = [
    Icon(Icons.search),
    Icon(
      FontAwesomeIcons.handshake,
      size: 25,
    ),
    Icon(Icons.notifications_active_outlined),
    Icon(Icons.home_outlined),
    Icon(Icons.more_horiz_outlined),
  ];

  List<Icon> _selectedIcons = [
    Icon(
      FontAwesomeIcons.magnifyingGlassLocation,
      size: 23,
    ),
        Icon(
      FontAwesomeIcons.solidHandshake,
      size: 23,
    ),
    Icon(Icons.notifications_active_rounded),
    Icon(Icons.home),
    Icon(Icons.more_horiz),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Search(),
          MyListings(),
          Notifications(),
          ManageProperties(),
          More(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 32,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
        selectedItemColor: Color.fromARGB(255, 253, 45, 30),
        unselectedItemColor: Colors.black,
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
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
      icon: _currentIndex == index
          ? _selectedIcons[index]
          : _unselectedIcons[index],
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
        return "Manage Property";
      case 4:
        return "More";
      default:
        return "";
    }
  }
}
