import 'package:client/data/properties.dart';
import 'package:client/model/list_property.dart';
import 'package:client/model/location.dart';
import 'package:client/model/property.dart';
import 'package:client/view/search/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FilterController extends GetxController {
  bool listingType = false; // true --> Buy, false --> Rent
  String currentCity = "";
  ListProperty listProperty = ListProperty(listDto: []);
  Rx<Location> location = Location(
    id: 0,
    streetAddress: "",
    city: "",
    region: "",
    postalCode: "",
    country: "",
    latitude: 0,
    longitude: 0,
  ).obs;

  // Property type
  bool buyHouse = true;
  bool buyHouseTemp = true;
  bool buyApartment = true;
  bool buyApartmentTemp = true;
  bool buyTownhouse = true;
  bool buyTownhouseTemp = true;
  bool buyCastle = true;
  bool buyCastleTemp = true;
  bool buyDepartment = true;
  bool buyDepartmentTemp = true;

  bool rentHouse = true;
  bool rentHouseTemp = true;
  bool rentApartment = true;
  bool rentApartmentTemp = true;
  bool rentTownhouse = true;
  bool rentTownhouseTemp = true;
  bool rentCastle = true;
  bool rentCastleTemp = true;
  bool rentDepartment = true;
  bool rentDepartmentTemp = true;

  // Price
  final buyMaxController = TextEditingController();
  final buyMinController = TextEditingController();
  final buyMaxControllerTemp = TextEditingController();
  final buyMinControllerTemp = TextEditingController();

  final rentMaxController = TextEditingController();
  final rentMinController = TextEditingController();
  final rentMaxControllerTemp = TextEditingController();
  final rentMinControllerTemp = TextEditingController();

  // Bed Bath
  RxString bedButtonTemp = "Any".obs;
  RxString bedButton = "Any".obs;
  RxString bathButtonTemp = "Any".obs;
  RxString bathButton = "Any".obs;

  final List<String> bedroomLabels = [
    'Any',
    'Studio+',
    '1+',
    '2+',
    '3+',
    '4+',
    '5+',
  ];

  final List<String> bathroomLabels = [
    'Any',
    '1+',
    '2+',
    '3+',
    '4+',
    '5+',
  ];

  // Property view
  String buyView = "Any";
  String buyViewTemp = "Any";
  String rentView = "Any";
  String rentViewTemp = "Any";

  // Listing by
  String buyListingBy = "Any";
  String buyListingByTemp = "Any";
  String rentListingBy = "Any";
  String rentListingByTemp = "Any";

  // Property size
  final buySizeMax = TextEditingController();
  final buySizeMin = TextEditingController();
  final buySizeMaxTemp = TextEditingController();
  final buySizeMinTemp = TextEditingController();

  final rentSizeMax = TextEditingController();
  final rentSizeMin = TextEditingController();
  final rentSizeMaxTemp = TextEditingController();
  final rentSizeMinTemp = TextEditingController();

  // Rent type
  String rentType = "All";
  String rentTypeTemp = "All";

  // Property status
  bool buyComingSoon = true;
  bool buyComingSoonTemp = true;
  bool buyAcceptingOffers = true;
  bool buyAcceptingOffersTemp = true;
  bool buyUnderContract = true;
  bool buyUnderContractTemp = true;

  bool rentComingSoon = true;
  bool rentComingSoonTemp = true;
  bool rentAcceptingOffers = true;
  bool rentAcceptingOffersTemp = true;
  bool rentUnderContract = true;
  bool rentUnderContractTemp = true;

  // Parking spots
  final buyParkingSpots = TextEditingController();
  final buyParkingSpotsTemp = TextEditingController();
  final rentParkingSpots = TextEditingController();
  final rentParkingSpotsTemp = TextEditingController();

  // Basement
  bool buyBasement = true;
  bool buyBasementTemp = true;
  bool rentBasement = true;
  bool rentBasementTemp = true;

  // Year built
  final buyYearBuiltMax = TextEditingController();
  final buyYearBuiltMin = TextEditingController();
  final buyYearBuiltMaxTemp = TextEditingController();
  final buyYearBuiltMinTemp = TextEditingController();

  final rentYearBuiltMax = TextEditingController();
  final rentYearBuiltMin = TextEditingController();
  final rentYearBuiltMaxTemp = TextEditingController();
  final rentYearBuiltMinTemp = TextEditingController();

  // For style when filter on
  bool filtersON = false;
  bool priceON = false;
  bool bedBathON = false;
  bool propertyTypeON = false;

  String priceText = "Price";
  String bedBathText = "Bed / Bath";
  String propertyTypeText = "Property type";
  String propertyTypeTextBuy = "Any";
  String propertyTypeTextRent = "Any";

  void checkFiltersON() {
    if (priceText != 'Price' ||
        bedBathText != "Bed / Bath" ||
        buyListingBy != "Any" ||
        rentListingBy != "Any" ||
        buyView != "Any" ||
        rentView != "Any" ||
        buySizeMax.text.isNotEmpty ||
        buySizeMin.text.isNotEmpty ||
        rentSizeMax.text.isNotEmpty ||
        rentSizeMin.text.isNotEmpty) {
      filtersON = true;
    } else {
      filtersON = false;
    }
    update();
  }

  void formatPriceRange(TextEditingController minController,
      TextEditingController maxController) {
    final minPrice = minController.text;
    final maxPrice = maxController.text;

    String formatValue(String value) {
      if (value.isEmpty) {
        priceText = 'Any';
      }
      final intValue = int.tryParse(value);
      if (intValue == null) {
        return value; // Not a valid number, return as is
      }
      if (intValue < 1000) {
        return '\$$intValue'; // Display as is if less than 1000
      }
      return '\$${(intValue / 1000).toStringAsFixed(0)}K'; // Format in K
    }

    if (minPrice.isNotEmpty && maxPrice.isNotEmpty) {
      priceText = '${formatValue(minPrice)} - ${formatValue(maxPrice)}';
      priceON = true;
    } else if (minPrice.isNotEmpty) {
      priceText = 'Min ${formatValue(minPrice)}';
      priceON = true;
    } else if (maxPrice.isNotEmpty) {
      priceText = 'Max ${formatValue(maxPrice)}';
      priceON = true;
    } else {
      priceText = 'Price';
      priceON = false;
    }
    update();
  }

  void formatBedBath() {
    if (bedButton.value != "Any" && bathButton.value != "Any") {
      bedBathText = "${bedButton.value} Bd / ${bathButton.value} Ba";
      bedBathON = true;
    } else if (bedButton.value != "Any") {
      bedBathText = "${bedButton.value} Bd / Any Ba";
      bedBathON = true;
    } else if (bathButton.value != "Any") {
      bedBathText = "Any Bd / ${bathButton.value} Ba";
      bedBathON = true;
    } else {
      bedBathText = "Bed / Bath";
      bedBathON = false;
    }
    update();
  }

  // String rentPropertyTypes() {
  //   if (!rentHouse &&
  //       !rentApartment &&
  //       !rentTownhouse &&
  //       !rentCastle &&
  //       !rentDepartment) {
  //     return 'Any';
  //   } else {
  //     List<String> selectedTypes = [];
  //     if (rentHouse) {
  //       selectedTypes.add('House');
  //     }
  //     if (rentApartment) {
  //       selectedTypes.add('Apartment Unit');
  //     }
  //     if (rentTownhouse) {
  //       selectedTypes.add('Townhouse');
  //     }
  //     if (rentCastle) {
  //       selectedTypes.add('Castle');
  //     }
  //     if (rentDepartment) {
  //       selectedTypes.add('Entire Department community');
  //     }
  //     return selectedTypes.join(', ');
  //   }
  // }

  // String buyPropertyTypes() {
  //   if (buyHouse &&
  //       buyApartment &&
  //       buyTownhouse &&
  //       buyCastle &&
  //       buyDepartment) {
  //     return 'Any';
  //   } else {
  //     List<String> selectedTypes = [];
  //     if (buyHouse) {
  //       selectedTypes.add('House');
  //     }
  //     if (buyApartment) {
  //       selectedTypes.add('Apartment Unit');
  //     }
  //     if (buyTownhouse) {
  //       selectedTypes.add('Townhouse');
  //     }
  //     if (buyCastle) {
  //       selectedTypes.add('Castle');
  //     }
  //     if (buyDepartment) {
  //       selectedTypes.add('Entire Department community');
  //     }
  //     return selectedTypes.join(', ');
  //   }
  // }

  getProperties() async {
    List<String>? propertyTypes = [];
    String? minPrice;
    String? maxPrice;
    String? numberOfBathrooms;
    String? numberOfBedrooms;
    String? view;
    String? listingPropertyType;
    List<String>? propertyStatus = [];

    String? minPropertySize;
    String? maxPropertySize;

    String? minBuiltYear;
    String? maxBuiltYear;

    String? parkingSpots;

    if (listingType) {
      if (buyHouse) {
        propertyTypes.add("House");
      }

      if (buyApartment) {
        propertyTypes.add("Apartment Unit");
      }

      if (buyTownhouse) {
        propertyTypes.add("Townhouse");
      }

      if (buyCastle) {
        propertyTypes.add("Castle");
      }

      if (buyDepartment) {
        propertyTypes.add("Entire Department Community");
      }

      if (buyComingSoon) {
        propertyStatus.add("Coming soon");
      }

      if (buyAcceptingOffers) {
        propertyStatus.add("Accepting offers");
      }

      if (buyUnderContract) {
        propertyStatus.add("Under contract");
      }

      minPrice = buyMinController.text;
      maxPrice = buyMaxController.text;

      minBuiltYear = buyYearBuiltMin.text;
      maxBuiltYear = buyYearBuiltMax.text;

      maxPropertySize = buySizeMax.text;
      minPropertySize = buySizeMin.text;

      parkingSpots = buyParkingSpots.text;

      view = buyView;
    } else {
      if (rentHouse) {
        propertyTypes.add("House");
      }

      if (rentApartment) {
        propertyTypes.add("Apartment Unit");
      }

      if (rentTownhouse) {
        propertyTypes.add("Townhouse");
      }

      if (rentCastle) {
        propertyTypes.add("Castle");
      }

      if (rentDepartment) {
        propertyTypes.add("Entire Department Community");
      }

      if (rentComingSoon) {
        propertyStatus.add("Coming soon");
      }

      if (rentAcceptingOffers) {
        propertyStatus.add("Accepting offers");
      }

      if (rentUnderContract) {
        propertyStatus.add("Under contract");
      }

      minPrice = rentMinController.text;
      maxPrice = rentMaxController.text;

      minBuiltYear = rentYearBuiltMin.text;
      maxBuiltYear = rentYearBuiltMax.text;

      maxPropertySize = rentSizeMax.text;
      minPropertySize = rentSizeMin.text;

      parkingSpots = rentParkingSpots.text;
      
      view = rentView;
    }

    if (bedButton.toString().length <= 2) {
      numberOfBedrooms = bedButton.string.substring(0, 1);
    } else {
      numberOfBedrooms = "";
    }

    if (bathButton.toString().length <= 2) {
      numberOfBathrooms = bathButton.string.substring(0, 1);
    } else {
      numberOfBathrooms = "";
    }
    // Rest of your code
    if (listingType) {
      listingPropertyType = "For sell";
    } else {
      listingPropertyType = "For rent";
    }
    var response = await PropertyData.getProperties(
        propertyTypes,
        minPrice,
        maxPrice,
        numberOfBathrooms,
        numberOfBedrooms,
        view,
        listingPropertyType.toString(),
        location,
        propertyStatus,
        minPropertySize,
        maxPropertySize,
        minBuiltYear,
        maxBuiltYear,
        parkingSpots,
        rentType);

    if (response['statusCode'] == 200) {
      listProperty = ListProperty.fromJson(response);
      print(listProperty.listDto);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
    }
  }

  List<MapMarker> getMarkerLocations(List<Property> properties) {
    return properties == []
        ? []
        : properties.map((property) {
            return MapMarker(
              property: property,
              position: LatLng(
                property.location?.latitude ?? 0.0,
                property.location?.longitude ?? 0.0,
              ),
            );
          }).toList();
  }

  void setBedButtonTemp(String label) {
    bedButtonTemp.value = label;
  }

  void setBathButtonTemp(String label) {
    bathButtonTemp.value = label;
  }

  bool isBedButtonTemp(String label) {
    return bedButtonTemp.value == label;
  }

  bool isBathButtonTemp(String label) {
    return bathButtonTemp.value == label;
  }

  void copyBedButton() {
    bedButton.value = bedButtonTemp.value;
  }

  void copyBathButton() {
    bathButton.value = bathButtonTemp.value;
  }

  void copyBedButtonTemp() {
    bedButtonTemp.value = bedButton.value;
  }

  void copyBathButtonTemp() {
    bathButtonTemp.value = bathButton.value;
  }
}
