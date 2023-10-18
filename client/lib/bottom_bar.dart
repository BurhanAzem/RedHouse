import 'package:client/more.dart';
import 'package:client/myhome.dart';
import 'package:client/mylistings.dart';
import 'package:client/notifications.dart';
import 'package:client/search.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final bool visitor;
  BottomBar(this.visitor, {Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 4;

  List<IconData> _unselectedIcons = [
    Icons.more_horiz_outlined,
    Icons.home_outlined,
    Icons.notifications_active_outlined,
    Icons.favorite_border,
    Icons.search,
  ];

  List<IconData> _selectedIcons = [
    Icons.more_horiz,
    Icons.home,
    Icons.notifications_active_rounded,
    Icons.favorite,
    Icons.saved_search,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          More(visitor: widget.visitor), 
          MyHome(),
          Notifications(),
          MyListings(), 
          Search(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 35,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
      icon: Icon(
        _currentIndex == index
            ? _selectedIcons[index]
            : _unselectedIcons[index],
      ),
      label: _getLabel(index),
    );
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return "More";
      case 1:
        return "My home";
      case 2:
        return "Notifications";
      case 3:
        return "My Listings";
      case 4:
        return "Search";
      default:
        return "";
    }
  }
}
