import 'package:client/model/contract.dart';
import 'package:client/view/contracts/details.dart';
import 'package:client/view/contracts/overview.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContractReview extends StatefulWidget {
  final Contract contract;
  const ContractReview({Key? key, required this.contract}) : super(key: key);

  @override
  State<ContractReview> createState() => _TopNavigationBar();
}

class _TopNavigationBar extends State<ContractReview>
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
        automaticallyImplyLeading: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String choice) {
              // Handle the selected choice
              print('Selected: $choice');
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Option 1',
                  child: Text('Proppose new contract'),
                ),
                const PopupMenuItem<String>(
                  value: 'Option 2',
                  child: Text('Request public feedback'),
                ),
                const PopupMenuItem<String>(
                  value: 'Option 3',
                  child: Text('End contract'),
                ),
              ];
            },
            icon: const Icon(Icons.more_vert_outlined, color: Colors.white),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Contract",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        // shrinkWrap: true,

        children: [
          Row(
            children: [
              const SizedBox(width: 25),
              Expanded(
                  child: ListTile(
                title: Text(
                  widget.contract!.offer!.landlord!.name!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text("Landlord"),
              )),
              IconButton(
                icon: const Icon(
                  FontAwesomeIcons.handshake,
                  size: 28,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 25),
            ],
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
                      fontWeight: FontWeight.w600,
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
                      Center(child: OverView(contract: widget.contract)),
                      const Center(
                        child: Text("It's rainy here"),
                      ),
                      Center(
                        child: Details(contract: widget.contract),
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
