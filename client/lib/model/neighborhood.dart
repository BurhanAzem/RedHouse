import 'package:client/model/location.dart';
import 'package:client/model/property.dart';
import 'package:json_annotation/json_annotation.dart';

part "neighborhood.g.dart";

@JsonSerializable()
class Neighborhood {
  int id;
  int propertyId;
  // Property property;
  String neighborhoodType;
  String? neighborhoodName;
  int locationId;
  Location? location;

  Neighborhood({
    required this.id,
    required this.propertyId,
    // required this.property,
    required this.neighborhoodType,
    this.neighborhoodName,
    required this.locationId,
    this.location,
  });

  factory Neighborhood.fromJson(Map<String, dynamic> json) =>
      _$NeighborhoodFromJson(json);
  Map<String, dynamic> toJson() => _$NeighborhoodToJson(this);
}
