import 'package:client/model/property.dart';
import 'package:client/view/bottom_bar/search/home%20information/home_information.dart';
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
            Get.to(() => HomeInformation(property: property));
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 35, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Brokered by the ${property.listingBy} ',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 12.5,
                            ),
                          ),
                          TextSpan(
                            text: 'Ayman Dwikat',
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 196, 39, 27),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 1),
                    Icon(
                      Icons.check_circle_outline,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image.network(
                        property.propertyFiles![0].downloadUrls!,
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                      ),
                    ),
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
                              color: Color.fromARGB(255, 196, 39, 27),
                            ),
                          ),
                          Text(
                            " ${property.listingType}",
                            style: const TextStyle(fontSize: 17.5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "\$${NumberFormat.decimalPattern().format(property.price)}${property.listingType == "For rent" ? "/mo" : ""}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        property.propertyType,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 196, 39, 27),
                        ),
                      ),
                      const SizedBox(height: 2),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${property.numberOfBedRooms} ',
                              style: const TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 196, 39, 27),
                              ),
                            ),
                            const TextSpan(
                              text: 'bedrooms, ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: '${property.numberOfBathRooms} ',
                              style: const TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 196, 39, 27),
                              ),
                            ),
                            const TextSpan(
                              text: 'bathrooms, ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: '${property.squareMetersArea} ',
                              style: const TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 196, 39, 27),
                              ),
                            ),
                            const TextSpan(
                              text: 'meters',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                property.location!.streetAddress,
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
                                Get.to(
                                    () => HomeInformation(property: property));
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
