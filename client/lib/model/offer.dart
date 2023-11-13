import 'package:client/model/property.dart';
import 'package:client/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
part "offer.g.dart";

@JsonSerializable()
class Offer {
  int id;
  int contractId;
  DateTime offerDate;
  DateTime offerExpires;
  String description;
  double price;
  String offerStatus;

  Offer(
      {required this.id,
      required this.contractId,
      required this.offerDate,
      required this.offerExpires,
      required this.description,
      required this.offerStatus,
      required this.price,
});

  factory Offer.fromJson(Map<String, dynamic> json) =>
      _$OfferFromJson(json);
  Map<String, dynamic> toJson() => _$OfferToJson(this);
}
