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

    controller.rentMaxControllerTemp.text = controller.rentMaxController.text;
    controller.rentMinControllerTemp.text = controller.rentMinController.text;
    controller.buyMaxControllerTemp.text = controller.buyMaxController.text;
    controller.buyMinControllerTemp.text = controller.buyMinController.text;

    controller.buyViewTemp = controller.buyView;
    controller.rentViewTemp = controller.rentView;

    controller.copyBathButtonTemp();
    controller.copyBedButtonTemp();

    controller.rentListingByTemp = controller.rentListingBy;
    controller.buyListingByTemp = controller.buyListingBy;

    controller.rentSizeMaxTemp.text = controller.rentSizeMax.text;
    controller.rentSizeMinTemp.text = controller.rentSizeMin.text;
    controller.buySizeMaxTemp.text = controller.buySizeMax.text;
    controller.buySizeMinTemp.text = controller.buySizeMin.text;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: controller.listingType ? 0 : 1,
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
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
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
