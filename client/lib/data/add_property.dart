import 'package:client/core/class/crud.dart';
import 'package:client/link_api.dart';


class PropertyData {
  Crud crud;
  PropertyData(this.crud);
  postdata(String propertyType ,String price ,String numberOfBedrooms ,
    String numberOfBathrooms, String squareMeter ,String propertyDescription,
    DateTime builtYear, String view, DateTime availableOn, String propertyStatus, String numberOfUnits,
    String parkingSpots, String listingType, String isAvaliableBasement, String listingBy,
    int userId) async {
    var response = await crud.postData(AppLink.add_property, {
      "propertyType" : propertyType , 
      "userId" : userId,
      "price" : price  , 
      "availableOn" : availableOn.toLocal().toString(),
      "numberOfBedrooms" : numberOfBedrooms , 
      "numberOfBathrooms" : numberOfBathrooms  , 
      "squareMeter" : squareMeter,
      "propertyDescription" : propertyDescription,
      "builtYear" : builtYear.toLocal().toString(),
      "view" : view,
      "propertyStatus" : propertyStatus,
      "numberOfUnits" : numberOfUnits,
      "parkingSpots" : parkingSpots,
      "listingType" : listingType,
      "isAvaliableBasement" : isAvaliableBasement,
      "listingBy" : listingBy,
      "locationDto":{},
      "neighborhoodDto":{}
    });
    return response.fold((l) => l, (r) => r);
  }
}