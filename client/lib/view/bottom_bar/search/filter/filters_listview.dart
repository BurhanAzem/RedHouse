import 'package:client/view/bottom_bar/search/filter/bedbath_filter.dart';
import 'package:client/view/bottom_bar/search/filter/filter_page.dart';
import 'package:client/view/bottom_bar/search/filter/price_filter.dart';
import 'package:client/view/bottom_bar/search/filter/propertytype_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterListView extends StatelessWidget {
  const FilterListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const Text("      "),
          MaterialButton(
              onPressed: () {
                Get.to(() => FilterPage());
              },
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: const BorderSide(
                  color: Color.fromARGB(255, 169, 169, 169),
                  width: 1.5,
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.tune, size: 20),
                  Text(
                    " Filters",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ],
              )),
          const Text("   "),
          Price(),
          const Text("   "),
          const BedBath(),
          const Text("   "),
          PropertyType(),
          const Text("      "),
        ],
      ),
    );
  }
}
