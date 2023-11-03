// ignore_for_file: non_constant_identifier_names
import 'package:client/model/location.dart';

class Property {
  int? PropertyId;
  String? PropertyType;
  int? UserId;
  List<String>? PropertyFiles;
  Location? PropertyLocation;
  int? Price;
  int? NumberOfBedRooms;
  int? NumberOfBathRooms;
  double? SquareMeter;
  String? PropertyDescription;
  DateTime? BuiltYear;
  String? View;
  //this
  DateTime? AvailableOn;
  String? PropertyStatus;
  int? NumberOfUnits;
  int? ParkingSpots;
  String? ListingType;
  String? IsAvailableBasement;
  String? ListingBy;

  Property({
    this.PropertyId,
    this.PropertyType,
    this.UserId,
    this.PropertyFiles,
    this.PropertyLocation,
    this.Price,
    this.NumberOfBedRooms,
    this.NumberOfBathRooms,
    this.SquareMeter,
    this.PropertyDescription,
    this.BuiltYear,
    this.View,
    this.AvailableOn,
    this.PropertyStatus,
    this.NumberOfUnits,
    this.ParkingSpots,
    this.ListingType,
    this.IsAvailableBasement,
    this.ListingBy,
  });
}
