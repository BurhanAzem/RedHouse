// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      Id: json['id'] as int,
      StreetAddress: json['streetAddress'] as String,
      City: json['city'] as String,
      Region: json['region'] as String,
      PostalCode: json['postalCode'] as String,
      Country: json['country'] as String,
      Latitude: (json['latitude'] as num).toDouble(),
      Longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'Id': instance.Id,
      'StreetAddress': instance.StreetAddress,
      'City': instance.City,
      'Region': instance.Region,
      'PostalCode': instance.PostalCode,
      'Country': instance.Country,
      'Latitude': instance.Latitude,
      'Longitude': instance.Longitude,
    };
