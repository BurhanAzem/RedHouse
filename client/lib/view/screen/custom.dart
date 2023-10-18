import 'package:client/controller/auth/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';





class Custom extends StatefulWidget {
  const Custom({super.key});

  @override
  State<Custom> createState() => _TopNavigationBar();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _TopNavigationBar extends State<Custom>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage properties'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              child: Text("Properties"),
            ),
            Tab(
              child: Text("Applications"),
            ),
            Tab(
              child: Text("Other"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(
            child: Text("It's cloudy here"),
          ),
          Center(
            child: Text("It's rainy here"),
          ),
          Center(
            child: Text("It's sunny here"),
          ),
        ],
      ),
    );
  }
}