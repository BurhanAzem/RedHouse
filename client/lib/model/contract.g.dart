// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contract _$ContractFromJson(Map<String, dynamic> json) => Contract(
      title: json['title'] as String,
      customerName: json['customerName'] as String,
      landlordName: json['landlordName'] as String,
      description: json['description'] as String,
      propertyId: json['propertyId'] as int,
      createdDate: DateTime.parse(json['createdDate'] as String),
      price: (json['price'] as num).toDouble(),
      contractType: json['contractType'] as String,
      contractStatus: json['contractStatus'] as String,
      earnings: (json['earnings'] as num).toDouble(),
      isShouldPay: json['isShouldPay'] as bool,
    );

Map<String, dynamic> _$ContractToJson(Contract instance) => <String, dynamic>{
      'title': instance.title,
      'customerName': instance.customerName,
      'landlordName': instance.landlordName,
      'description': instance.description,
      'propertyId': instance.propertyId,
      'createdDate': instance.createdDate.toIso8601String(),
      'price': instance.price,
      'contractType': instance.contractType,
      'contractStatus': instance.contractStatus,
      'earnings': instance.earnings,
      'isShouldPay': instance.isShouldPay,
    };
