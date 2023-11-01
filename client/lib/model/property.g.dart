// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      Id: json['id'] as int,
      PropertyType: json['propertyType'] as String,
      UserId: json['userId'] as int,
      PropertyFiles: (json['propertyFiles'] as List<dynamic>)
          .map((e) => PropertyFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      LocationId: json['locationId'] as int,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      Price: json['price'] as int,
      NumberOfBedRooms: json['numberOfBedRooms'] as int,
      NumberOfBathRooms: json['numberOfBathRooms'] as int,
      squareMetersArea: json['squareMetersArea'] as int,
      PropertyDescription: json['propertyDescription'] as String,
      BuiltYear: DateTime.parse(json['builtYear'] as String),
      View: json['view'] as String,
      AvailableOn: DateTime.parse(json['availableOn'] as String),
      PropertyStatus: json['propertyStatus'] as String,
      NumberOfUnits: json['numberOfUnits'] as int,
      ParkingSpots: json['parkingSpots'] as int,
      ListingType: json['listingType'] as String,
      IsAvailableBasement: json['isAvailableBasement'] as String,
      ListingBy: json['listingBy'] as String,
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
      'SquareMeter': instance.squareMetersArea,
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
