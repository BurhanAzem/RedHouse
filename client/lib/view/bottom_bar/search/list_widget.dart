import 'package:client/model/property.dart';
import 'package:client/view/bottom_bar/search/home_information.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'filter/filter_page.dart';

class ListWidget extends StatelessWidget {
  final Set<Property> properties;
  const ListWidget({Key? key, required this.properties}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) {
      return Center(
        child: Container(
          margin: const EdgeInsetsDirectional.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              SvgPicture.asset(
                'assets/images/house_searching.svg',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 30),
              const Text(
                "Oops! No results found",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "Try changing or removing some of your filters or adjusting your search",
                style: TextStyle(fontSize: 17),
              ),
              const Text(
                "area.",
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 17),
              Container(
                width: 190,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () {
                    Get.to(() => FilterPage());
                  },
                  height: 45,
                  color: Colors.black87,
                  child: const Center(
                    child: Text(
                      "Edit search",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: properties.length,
      itemBuilder: (context, index) {
        Property property = properties.elementAt(index);
        return InkWell(
          onTap: () {
            Get.to(() => const HomeInformation());
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 35, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Brokered by Foster Realty", // landlord name
                      style: TextStyle(fontSize: 12.5, color: Colors.grey[600]),
                    ),
                    SizedBox(width: 1),
                    Icon(
                      Icons.check_circle_outline,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
                SizedBox(height: 1),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(
                        property.propertyFiles![0].downloadUrls!,
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        bottom: 16,
                        right: 16,
                        child: Stack(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 4, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 44, 162, 46),
                            ),
                          ),
                          Text(
                            " ${property.propertyStatus}",
                            style: const TextStyle(fontSize: 17.5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "ID = ${property.id}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "\$${NumberFormat.decimalPattern().format(property.price)}${property.propertyStatus == "For Rent" ? "/mo" : ""}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${property.numberOfBedRooms} bedroom, ${property.numberOfBathRooms} bathroom, ${NumberFormat.decimalPattern().format(property.squareMetersArea)} meters",
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${property.location!.streetAddress}",
                                style: const TextStyle(fontSize: 14.5),
                              ),
                              const SizedBox(height: 1),
                              Text(
                                "${property.location!.city}, ${property.location!.country}",
                                style: const TextStyle(fontSize: 14.5),
                              ),
                            ],
                          ),
                          Container(
                            width: 180,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: const BorderSide(
                                    color: Colors.black, width: 1.4),
                              ),
                              onPressed: () {
                                Get.to(() => HomeInformation());
                              },
                              height: 37,
                              child: const Center(
                                child: Text(
                                  "Check availability",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
