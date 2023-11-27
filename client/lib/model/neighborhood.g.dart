// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'neighborhood.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Neighborhood _$NeighborhoodFromJson(Map<String, dynamic> json) => Neighborhood(
      id: json['id'] as int,
      propertyId: json['propertyId'] as int,
      // property: Property.fromJson(json['property'] as Map<String, dynamic>),
      neighborhoodType: json['neighborhoodType'] as String,
      neighborhoodName: json['neighborhoodName'] as String?,
      locationId: json['locationId'] as int,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NeighborhoodToJson(Neighborhood instance) =>
    <String, dynamic>{
      'id': instance.id,
      'propertyId': instance.propertyId,
      // 'property': instance.property,
      'neighborhoodType': instance.neighborhoodType,
      'neighborhoodName': instance.neighborhoodName,
      'locationId': instance.locationId,
      'location': instance.location,
    };
