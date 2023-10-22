import 'package:client/view/screen/filter/PropertyTypeContent.dart';
import 'package:client/view/screen/filter/RowEnterPrice%20.dart';
import 'package:client/view/screen/filter/price_filter.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
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
              Tab(text: 'Rent'),
              Tab(text: 'Buy'),
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
            Center(child: Text('This is the Buy Tab')),
            ListView(
              children: [
                MaterialButton(
                  onPressed: () {
                    
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Property type",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                const Align(
                    alignment: Alignment.centerRight,
                    child: Text("Price    ", style: TextStyle(fontSize: 20))),
                Container(height: 15),
                RowEnterPrice(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
