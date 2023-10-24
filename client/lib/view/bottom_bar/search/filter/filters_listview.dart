import 'package:client/view/bottom_bar/search/filter/bed_bath_filter.dart';
import 'package:client/view/bottom_bar/search/filter/filter_page.dart';
import 'package:client/view/bottom_bar/search/filter/price_filter.dart';
import 'package:client/view/bottom_bar/search/filter/property_type_filter.dart';
import 'package:client/view/bottom_bar/search/filter/property_type_sheet%20.dart';
import 'package:flutter/material.dart';

class FilterListView extends StatefulWidget {
  @override
  _FilterListViewState createState() => _FilterListViewState();
}

class _FilterListViewState extends State<FilterListView> {
  final propertyTypeSelection = PropertyTypeSelection();
  // final buyNaxController = TextEditingController();
  // final buyMinController = TextEditingController();
  // final rentMaxController = TextEditingController();
  // final rentMinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Text("      "),
          PropertyType(selection: propertyTypeSelection),
          Text("   "),
          BedBath(),
          Text("   "),
          Price(
            selection: propertyTypeSelection,
          ),
          Text("   "),
          MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FilterPage(selection: propertyTypeSelection),
                  ),
                );
                print(propertyTypeSelection.buy_ApartmentChecked);
                print(propertyTypeSelection.buy_HomeChecked);
                print("=====================================================");
                print(propertyTypeSelection.rent_CondoChecked);
                print(propertyTypeSelection.rent_TownhomeChecked);
              },
              padding: EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: BorderSide(
                  color: Colors.grey,
                  width: 1.6,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.tune, size: 21),
                  Text(
                    " Filters",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              )),
          Text("      "),
        ],
      ),
    );
  }
}
