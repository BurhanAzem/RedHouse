// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      Id: json['Id'] as int,
      PropertyType: json['PropertyType'] as String,
      UserId: json['UserId'] as int,
      PropertyFiles: (json['PropertyFiles'] as List<dynamic>)
          .map((e) => PropertyFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      LocationId: json['LocationId'] as int,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      Price: json['Price'] as int,
      NumberOfBedRooms: json['NumberOfBedRooms'] as int,
      NumberOfBathRooms: json['NumberOfBathRooms'] as int,
      squareMetersArea: json['squareMetersArea'] as int,
      PropertyDescription: json['PropertyDescription'] as String,
      BuiltYear: DateTime.parse(json['BuiltYear'] as String),
      View: json['View'] as String,
      AvailableOn: DateTime.parse(json['AvailableOn'] as String),
      PropertyStatus: json['PropertyStatus'] as String,
      NumberOfUnits: json['NumberOfUnits'] as int,
      ParkingSpots: json['ParkingSpots'] as int,
      ListingType: json['ListingType'] as String,
      IsAvailableBasement: json['IsAvailableBasement'] as String,
      ListingBy: json['ListingBy'] as String,
    );

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'Id': instance.Id,
      'PropertyType': instance.PropertyType,
      'UserId': instance.UserId,
      'LocationId': instance.LocationId,
      'PropertyFiles': instance.PropertyFiles,
      'location': instance.location,
      'Price': instance.Price,
      'NumberOfBedRooms': instance.NumberOfBedRooms,
      'NumberOfBathRooms': instance.NumberOfBathRooms,
      'squareMetersArea': instance.squareMetersArea,
      'PropertyDescription': instance.PropertyDescription,
      'BuiltYear': instance.BuiltYear.toIso8601String(),
      'View': instance.View,
      'AvailableOn': instance.AvailableOn.toIso8601String(),
      'PropertyStatus': instance.PropertyStatus,
      'NumberOfUnits': instance.NumberOfUnits,
      'ParkingSpots': instance.ParkingSpots,
      'ListingType': instance.ListingType,
      'IsAvailableBasement': instance.IsAvailableBasement,
      'ListingBy': instance.ListingBy,
    };
