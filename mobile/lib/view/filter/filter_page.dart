import 'package:client/controller/bottom_bar/filter_controller.dart';
import 'package:client/view/filter/buy_filter.dart';
import 'package:client/view/filter/rent_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterPage extends StatefulWidget {
  FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  FilterController controller = Get.put(FilterController());

  @override
  void initState() {
    super.initState();

    // Property type
    controller.buyHouseTemp = controller.buyHouse;
    controller.buyApartmentTemp = controller.buyApartment;
    controller.buyTownhouseTemp = controller.buyTownhouse;
    controller.buyCastleTemp = controller.buyCastle;
    controller.buyDepartmentTemp = controller.buyDepartment;

    controller.rentHouseTemp = controller.rentHouse;
    controller.rentApartmentTemp = controller.rentApartment;
    controller.rentTownhouseTemp = controller.rentTownhouse;
    controller.rentCastleTemp = controller.rentCastle;
    controller.rentDepartmentTemp = controller.rentDepartment;

    // Price
    controller.buyMaxControllerTemp.text = controller.buyMaxController.text;
    controller.buyMinControllerTemp.text = controller.buyMinController.text;
    controller.rentMaxControllerTemp.text = controller.rentMaxController.text;
    controller.rentMinControllerTemp.text = controller.rentMinController.text;

    // Property view
    controller.buyViewTemp = controller.buyView;
    controller.rentViewTemp = controller.rentView;

    // Bed Bath
    controller.copyBathButtonTemp();
    controller.copyBedButtonTemp();

    // Listing by
    controller.buyListingByTemp = controller.buyListingBy;
    controller.rentListingByTemp = controller.rentListingBy;

    // Property size
    controller.buySizeMaxTemp.text = controller.buySizeMax.text;
    controller.buySizeMinTemp.text = controller.buySizeMin.text;
    controller.rentSizeMaxTemp.text = controller.rentSizeMax.text;
    controller.rentSizeMinTemp.text = controller.rentSizeMin.text;

    // Rent type
    controller.rentTypeTemp = controller.rentType;

    // Property status
    controller.buyComingSoonTemp = controller.buyComingSoon;
    controller.buyAcceptingOffersTemp = controller.buyAcceptingOffers;
    controller.buyUnderContractTemp = controller.buyUnderContract;
    controller.rentComingSoonTemp = controller.rentComingSoon;
    controller.rentAcceptingOffersTemp = controller.rentAcceptingOffers;
    controller.rentUnderContractTemp = controller.rentUnderContract;

    // Parking spots
    controller.buyParkingSpotsTemp.text = controller.buyParkingSpots.text;
    controller.rentParkingSpotsTemp.text = controller.rentParkingSpots.text;

    // Basement
    controller.buyBasementTemp = controller.buyBasement;
    controller.rentBasementTemp = controller.rentBasement;

    // Year built
    controller.buyYearBuiltMaxTemp.text = controller.buyYearBuiltMax.text;
    controller.buyYearBuiltMinTemp.text = controller.buyYearBuiltMin.text;
    controller.rentYearBuiltMaxTemp.text = controller.rentYearBuiltMax.text;
    controller.rentYearBuiltMinTemp.text = controller.rentYearBuiltMin.text;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: controller.listingType ? 0 : 1,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  'Filters',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    controller.rentMaxControllerTemp.text = "";
                    controller.rentMinControllerTemp.text = "";
                    controller.buyMaxControllerTemp.text = "";
                    controller.buyMinControllerTemp.text = "";

                    controller.buyViewTemp = "Any";
                    controller.rentViewTemp = "Any";

                    controller.setBedButtonTemp("Any");
                    controller.setBathButtonTemp("Any");

                    controller.rentListingByTemp = "Any";
                    controller.buyListingByTemp = "Any";

                    controller.rentSizeMaxTemp.text = "";
                    controller.rentSizeMinTemp.text = "";
                    controller.buySizeMaxTemp.text = "";
                    controller.buySizeMinTemp.text = "";
                  });
                },
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 17.5,
                  ),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Buy'),
              Tab(text: 'Rent'),
            ],
            overlayColor: MaterialStatePropertyAll(Colors.grey[700]),
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            unselectedLabelColor: Colors.grey[400],
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 17,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            BuyFilter(),
            RentFilter(),
          ],
        ),
      ),
    );
  }
}
