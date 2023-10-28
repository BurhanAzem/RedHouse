import 'package:client/view/bottom_bar/contract/mylistings.dart';
import 'package:client/view/bottom_bar/more/more.dart';
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

  final List<Icon> _unselectedIcons = [
    const Icon(Icons.search),
    const Icon(
      FontAwesomeIcons.handshake,
      size: 25,
    ),
    const Icon(Icons.notifications_active_outlined),
    const Icon(Icons.home_outlined),
    const Icon(Icons.more_horiz_outlined),
  ];

  final List<Icon> _selectedIcons = [
    const Icon(
      FontAwesomeIcons.magnifyingGlassLocation,
      size: 23,
    ),
    const Icon(
      FontAwesomeIcons.solidHandshake,
      size: 23,
    ),
    const Icon(Icons.notifications_active_rounded),
    const Icon(Icons.home),
    const Icon(Icons.more_horiz),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const Search(),
          const MyListings(),
          const Notifications(),
          const ManageProperties(),
          More(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 32,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 253, 45, 30),
        unselectedItemColor: Colors.black,
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 11.5),
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
