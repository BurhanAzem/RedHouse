// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contract _$ContractFromJson(Map<String, dynamic> json) => Contract(
      id: json['id'] as int,
      customerId: json['customerId'] as int,
      landlordId: json['landlordId'] as int,
      description: json['description'] as String,
      propertyId: json['propertyId'] as int,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      price: (json['price'] as num).toDouble(),
      contractType: json['contractType'] as String,
      contractStatus: json['contractStatus'] as String,
      earnings: (json['earnings'] as num).toDouble(),
      isShouldPay: json['isShouldPay'] as int,
      customer: json['customer'] == null
          ? null
          : User.fromJson(json['customer'] as Map<String, dynamic>),
      landlord: json['landlord'] == null
          ? null
          : User.fromJson(json['landlord'] as Map<String, dynamic>),
      property: json['property'] == null
          ? null
          : Property.fromJson(json['property'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContractToJson(Contract instance) => <String, dynamic>{
      'id': instance.id,
      'propertyId': instance.propertyId,
      'landlordId': instance.landlordId,
      'customerId': instance.customerId,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'description': instance.description,
      'price': instance.price,
      'contractType': instance.contractType,
      'contractStatus': instance.contractStatus,
      'earnings': instance.earnings,
      'isShouldPay': instance.isShouldPay,
      'customer': instance.customer,
      'landlord': instance.landlord,
      'property': instance.property,
    };
