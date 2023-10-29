import 'package:client/view/manage_properties/properties.dart';
import 'package:flutter/material.dart';

class Contract extends StatefulWidget {
  const Contract({super.key});

  @override
  State<Contract> createState() => _TopNavigationBar();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _TopNavigationBar extends State<Contract>
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
              child: Text("Overview"),
            ),
            Tab(
              child: Text("Messages"),
            ),
            Tab(
              child: Text("Details"),
            ),
          ],
          overlayColor: MaterialStatePropertyAll(Colors.grey[350]),
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
          unselectedLabelColor: Colors.grey[700],
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 17,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(child: Properties()),
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
