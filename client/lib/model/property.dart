import 'dart:ffi';

import 'package:client/model/location.dart';
import 'package:client/model/property_files.dart';
import 'package:client/model/user.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part "property.g.dart";

@JsonSerializable()
class Property {
  int id;
  String propertyType;
  int userId;
  User ?user;
  String propertyCode;
  int locationId;
  List<PropertyFile>? propertyFiles;
  Location? location;
  int price;
  int numberOfBedRooms;
  int numberOfBathRooms;
  int squareMetersArea;
  String propertyDescription;
  DateTime builtYear;
  String view;
  DateTime availableOn;
  String propertyStatus;
  int numberOfUnits;
  int parkingSpots;
  String listingType;
  String isAvailableBasement;
  String listingBy;

  Property({
   required this.id,
   required this.propertyType,
   required this.userId,
   this.user,
   required this.propertyCode,
   this.propertyFiles,
   required this.locationId,
   this.location,
   required this.price,
   required this.numberOfBedRooms,
   required this.numberOfBathRooms,
   required this.squareMetersArea,
   required this.propertyDescription,
   required this.builtYear,
   required this.view,
   required this.availableOn,
   required this.propertyStatus,
   required this.numberOfUnits,
   required this.parkingSpots,
   required this.listingType,
   required this.isAvailableBasement,
   required this.listingBy,
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
