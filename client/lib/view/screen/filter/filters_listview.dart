import 'package:client/view/screen/filter/bed_bath_filter.dart';
import 'package:client/view/screen/filter/filters_filter.dart';
import 'package:client/view/screen/filter/price_filter.dart';
import 'package:client/view/screen/filter/property_type_filter.dart';
import 'package:flutter/material.dart';

class FilterListView extends StatefulWidget {
  @override
  _FilterListViewState createState() => _FilterListViewState();
}

class _FilterListViewState extends State<FilterListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          Text("      "),
          PropertyType(),
          Text("   "),
          BedBath(),
          Text("   "),
          Price(),
          Text("   "),
          Filters(),
          Text("      "),
        ],
      ),
    );
  }
}
