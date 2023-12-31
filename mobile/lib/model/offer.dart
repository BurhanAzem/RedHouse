import 'package:client/model/property.dart';
import 'package:client/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
part "offer.g.dart";

@JsonSerializable()
class Offer {
  int id;
  int landlordId;
  int customerId;
  int? propertryId;
  DateTime offerDate;
  DateTime offerExpires;
  String description;
  int price;
  String offerStatus;
  User? landlord;
  User? customer;
  Property? property;

  Offer({
    required this.id,
    required this.landlordId,
    required this.customerId,
    required this.propertryId,
    required this.offerDate,
    required this.offerExpires,
    required this.description,
    required this.offerStatus,
    required this.price,
    this.landlord,
    this.customer,
    this.property,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);
  Map<String, dynamic> toJson() => _$OfferToJson(this);
}
