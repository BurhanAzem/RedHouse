import 'package:client/model/contract.dart';
import 'package:client/view/contracts/details.dart';
import 'package:client/view/contracts/overview.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LandlordContract extends StatefulWidget {
  final Contract contract;
  const LandlordContract({Key? key, required this.contract}) : super(key: key);

  @override
  State<LandlordContract> createState() => _LandlordContractState();
}

class _LandlordContractState extends State<LandlordContract>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Contract",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
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
      ),
      body: Column(
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
            child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Scaffold(
                appBar: TabBar(
                  tabs: const [
                    Tab(child: Text("Overview")),
                    Tab(child: Text("Messages")),
                    Tab(child: Text("Details")),
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
                    Center(child: Overview(contract: widget.contract)),
                    const Center(child: Text("It's rainy here")),
                    Center(child: Details(contract: widget.contract)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
