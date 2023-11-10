import 'package:client/view/contracts/overview.dart';
import 'package:client/view/manage_properties/properties.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Contract extends StatefulWidget {
  const Contract({Key? key}) : super(key: key);

  @override
  State<Contract> createState() => _TopNavigationBar();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _TopNavigationBar extends State<Contract> with TickerProviderStateMixin {
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
        centerTitle: true,
        title: const Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "                   C",
              style: TextStyle(
                color: Color(0xffd92328),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "ontract",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 25),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[400],
                ),
                child: Center(
                  child: Icon(
                    FontAwesomeIcons.person,
                    size: 28,
                    color: Colors.grey[100],
                  ),
                ),
              ),
              Expanded(
                  child: ListTile(
                title: Text(
                  "hfvgih",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Landlord"),
              )),
              IconButton(
                icon: const Icon(
                  Icons.more_horiz_outlined,
                  size: 32,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 25),
            ],
          ),
          Container(
            margin: EdgeInsets.all(10), // Adjust the margin as needed
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(children: [
              Row(
                children: [
                  Icon(Icons.circle),
                  Text("    Property price"),
                  Text("                                   500\$")
                ],
              ),
              Row(
                children: [
                  Icon(Icons.circle,
                  color: Color(0xffd92328),),
                  Text("    Received"),
                  Text("                                            500\$")
                ],
              ),  
              // Row(
              //   children: [
              //     Icon(Icons.circle,
              //     color: Colors.grey,),
              //     Text("    Receved"),
              //     Text("                                            500\$")
              //   ],
              // )
            ]),
          ),
          Expanded(
            child: Container(
              child: DefaultTabController(
                length: 3,
                initialIndex: 0,
                child: Scaffold(
                  appBar: TabBar(
                    tabs: const [
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
                  body: TabBarView(
                    children: [
                      Center(child: OverView()),
                      Center(
                        child: Text("It's rainy here"),
                      ),
                      Center(
                        child: Text("It's sunny here"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
