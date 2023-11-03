// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contract _$ContractFromJson(Map<String, dynamic> json) => Contract(
      Title: json['Title'] as String,
      CustomerName: json['CustomerName'] as String,
      LandlordName: json['LandlordName'] as String,
      Description: json['Description'] as String,
      PropertyId: json['PropertyId'] as int,
      CreatedDate: DateTime.parse(json['CreatedDate'] as String),
      Price: (json['Price'] as num).toDouble(),
      ContractType: json['ContractType'] as String,
      ContractStatus: json['ContractStatus'] as String,
      Earnings: (json['Earnings'] as num).toDouble(),
      IsShouldPay: json['IsShouldPay'] as bool,
    );

Map<String, dynamic> _$ContractToJson(Contract instance) => <String, dynamic>{
      'Title': instance.Title,
      'CustomerName': instance.CustomerName,
      'LandlordName': instance.LandlordName,
      'Description': instance.Description,
      'PropertyId': instance.PropertyId,
      'CreatedDate': instance.CreatedDate.toIso8601String(),
      'Price': instance.Price,
      'ContractType': instance.ContractType,
      'ContractStatus': instance.ContractStatus,
      'Earnings': instance.Earnings,
      'IsShouldPay': instance.IsShouldPay,
    };
