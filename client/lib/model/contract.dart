import 'package:json_annotation/json_annotation.dart';

part "contract.g.dart";

@JsonSerializable()
class Contract {
  String title;
  String customerName;
  String landlordName;
  String description;
  int propertyId;
  DateTime createdDate;
  double price;
  String contractType;
  String contractStatus;
  double earnings;
  bool isShouldPay;

  Contract(
      {required this.title,
      required this.customerName,
      required this.landlordName,
      required this.description,
      required this.propertyId,
      required this.createdDate,
      required this.price,
      required this.contractType,
      required this.contractStatus,
      required this.earnings,
      required this.isShouldPay});

  factory Contract.fromJson(Map<String, dynamic> json) =>
      _$ContractFromJson(json);
  Map<String, dynamic> toJson() => _$ContractToJson(this);
}
