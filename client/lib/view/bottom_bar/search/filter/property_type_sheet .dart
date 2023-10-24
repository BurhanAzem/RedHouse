import 'package:flutter/material.dart';

class PropertyTypeSelection {
  bool listingType = true; // true --> Buy, false --> Rent

  bool buy_ApartmentChecked = true;
  bool buy_HomeChecked = true;

  bool rent_CondoChecked = true;
  bool rent_TownhomeChecked = true;

  // int buy_NoMax = 0;
  // int buy_NoMin = 0;
  // int rent_NoMax = 0;
  // int rent_NoMin = 0;

  final buyMaxController = TextEditingController();
  final buyMinController = TextEditingController();
  final rentMaxController = TextEditingController();
  final rentMinController = TextEditingController();

  void checkAllBuyCheckboxes() {
    buy_ApartmentChecked = true;
    buy_HomeChecked = true;
  }

  void checkAllRentCheckboxes() {
    rent_CondoChecked = true;
    rent_TownhomeChecked = true;
  }
}
