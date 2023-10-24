import 'package:client/view/bottom_bar/search/filter/BuyFilter.dart';
import 'package:client/view/bottom_bar/search/filter/RentFilter.dart';
import 'package:client/view/bottom_bar/search/filter/property_type_sheet%20.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  PropertyTypeSelection selection;
  FilterPage({Key? key, required this.selection}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.selection.listingType ? 0 : 1,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  'Filters',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Buy'),
              Tab(text: 'Rent'),
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
          children: [
            BuyFilter(selection: widget.selection),
            RentFilter(selection: widget.selection),
          ],
        ),
      ),
    );
  }
}
