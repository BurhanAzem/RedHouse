import 'package:client/model/location.dart';
import 'package:client/model/property_files.dart';
import 'package:json_annotation/json_annotation.dart';
part "property.g.dart";

@JsonSerializable()
class Property {
  int Id;
  String PropertyType;
  int UserId;
  int LocationId;
  List<PropertyFile> PropertyFiles;
  Location location;
  int Price;
  int NumberOfBedRooms;
  int NumberOfBathRooms;
  int squareMetersArea;
  String PropertyDescription;
  DateTime BuiltYear;
  String View;
  DateTime AvailableOn;
  String PropertyStatus;
  int NumberOfUnits;
  int ParkingSpots;
  String ListingType;
  String IsAvailableBasement;
  String ListingBy;

  Property({
   required this.Id,
   required this.PropertyType,
   required this.UserId,
   required this.PropertyFiles,
   required this.LocationId,
   required this.location,
   required this.Price,
   required this.NumberOfBedRooms,
   required this.NumberOfBathRooms,
   required this.squareMetersArea,
   required this.PropertyDescription,
   required this.BuiltYear,
   required this.View,
   required this.AvailableOn,
   required this.PropertyStatus,
   required this.NumberOfUnits,
   required this.ParkingSpots,
   required this.ListingType,
   required this.IsAvailableBasement,
   required this.ListingBy,
  });

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}
