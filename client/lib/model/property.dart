import 'dart:ffi';

import 'package:client/model/location.dart';
import 'package:client/model/property_files.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part "property.g.dart";

@JsonSerializable()
class Property {
  int Id;
  String PropertyType;
  int UserId;
  String PropertyCode;
  int LocationId;
  List<PropertyFile>? PropertyFiles;
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
   required this.PropertyCode,
   this.PropertyFiles,
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

  // factory Property.fromJson(Map<String, dynamic> json) {
  //   List<PropertyFile>? propertyFiles;
  //   final dynamic propertyFilesJson = json['PropertyFiles'];

  //   if (propertyFilesJson is List) {
  //     final jsonItems = propertyFilesJson.cast<Map<String, dynamic>>();
  //     propertyFiles = jsonItems.map((fileJson) => PropertyFile.fromJson(fileJson)).toList();
  //   }

  //   return Property(
  //     PropertyId: json['PropertyId'],
  //     PropertyType: json['PropertyType'],
  //     UserId: json['UserId'],
  //     Price: json['Price'],
  //     NumberOfBedRooms: json['NumberOfBedRooms'],
  //     PropertyFiles: propertyFiles,
  //     PropertyLocation: Location.fromJson(json['location']),
  //     NumberOfBathRooms: json['NumberOfBathRooms'],
  //     SquareMeter: json['SquareMeter']?.toDouble(),
  //     PropertyDescription: json['PropertyDescription'],
  //     BuiltYear: _parseDateTime(json['BuiltYear']),
  //     View: json['View'],
  //     AvailableOn: _parseDateTime(json['AvailableOn']),
  //     PropertyStatus: json['PropertyStatus'],
  //     NumberOfUnits: json['NumberOfUnits'],
  //     ParkingSpots: json['ParkingSpots'],
  //     ListingType: json['ListingType'],
  //     IsAvailableBasement: json['IsAvailableBasement'],
  //     ListingBy: json['ListingBy'],
  //   );
  // }

  // // Helper method to parse DateTime values from the JSON
  // static DateTime? _parseDateTime(String? dateString) {
  //   if (dateString != null) {
  //     DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  //     return dateFormat.parse(dateString);
  //   }
  //   return null;
  // }

  // // toJson method for serialization
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['PropertyId'] = this.PropertyId;
  //   data['PropertyType'] = this.PropertyType;
  //   data['UserId'] = this.UserId;
  //   data['Price'] = this.Price;
  //   // Add more fields as needed...
  //   return data;
  // }
}
