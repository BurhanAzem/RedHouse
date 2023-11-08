import 'package:client/model/property.dart';
import 'package:client/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part "contract.g.dart";

@JsonSerializable()
class Contract {
  int id;
  int propertyId;
  int landlordId;
  int customerId;
  DateTime startDate;
  DateTime endDate;

  String description;
  double price;
  String contractType;
  String contractStatus;
  double earnings;
  int isShouldPay;
  User? customer;
  User? landlord;
  Property? property;

  Contract(
      {required this.id,
      required this.customerId,
      required this.landlordId,
      required this.description,
      required this.propertyId,
      required this.startDate,
      required this.endDate,
      required this.price,
      required this.contractType,
      required this.contractStatus,
      required this.earnings,
      required this.isShouldPay,
       this.customer,
       this.landlord,
       this.property
      
      });

  factory Contract.fromJson(Map<String, dynamic> json) =>
      _$ContractFromJson(json);
  Map<String, dynamic> toJson() => _$ContractToJson(this);
}
