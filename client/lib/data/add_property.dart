import 'package:client/core/class/crud.dart';
import 'package:client/link_api.dart';
import 'package:intl/intl.dart';

class PropertyData {
  Crud crud;
  PropertyData(this.crud);
  postdata(
      String propertyType,
      String price,
      String numberOfBedrooms,
      String numberOfBathrooms,
      String squareMeter,
      String propertyDescription,
      DateTime builtYear,
      String view,
      DateTime availableOn,
      String propertyStatus,
      String numberOfUnits,
      String parkingSpots,
      String listingType,
      String isAvailableBasement,
      String listingBy,
      int userId,
      List<String> downloadUrls,
      String streetAddress,
      String city,
      String region,
      String postalCode,
      String country,
      dynamic latitude,
      dynamic longitude) async {
    String formattedBuiltYear =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(builtYear);
    String formattedAvailableOn =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(availableOn);

    var response = await crud.postData(AppLink.add_property, {
      "propertyType": propertyType,
      "userId": userId,
      "price": int.tryParse(price) ?? 0,
      "availableOn": formattedAvailableOn,
      "numberOfBedrooms": int.tryParse(numberOfBedrooms) ?? 0,
      "numberOfBathrooms": int.tryParse(numberOfBathrooms) ?? 0,
      "squareMeter": int.tryParse(squareMeter) ?? 0,
      "propertyDescription": propertyDescription,
      "builtYear": formattedBuiltYear,
      "view": view,
      "propertyStatus": propertyStatus,
      "numberOfUnits": int.tryParse(numberOfUnits) ?? 0,
      "parkingSpots": int.tryParse(parkingSpots) ?? 0,
      "listingType": listingType,
      "isAvailableBasement": isAvailableBasement,
      "listingBy": listingBy,
      "locationDto": {
        "streetAddress": streetAddress,
        "city": city,
        "region": region,
        "postalCode": postalCode,
        "country": country,
        "latitude": latitude,
        "longitude": longitude
      },
      // "neighborhoodDto":{},
      "propertyFiles": downloadUrls
    });
    return response.fold((l) => l, (r) => r);
  }
}
