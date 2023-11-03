import 'package:json_annotation/json_annotation.dart';

part "contract.g.dart";

@JsonSerializable()
class Contract {
  String Title;
  String CustomerName;
  String LandlordName;
  String Description;
  int PropertyId;
  DateTime CreatedDate;
  double Price;
  String ContractType;
  String ContractStatus;
  double Earnings;
  bool IsShouldPay;

  Contract(
      {required this.Title,
      required this.CustomerName,
      required this.LandlordName,
      required this.Description,
      required this.PropertyId,
      required this.CreatedDate,
      required this.Price,
      required this.ContractType,
      required this.ContractStatus,
      required this.Earnings,
      required this.IsShouldPay});

  factory Contract.fromJson(Map<String, dynamic> json) =>
      _$ContractFromJson(json);
  Map<String, dynamic> toJson() => _$ContractToJson(this);
}
