 import 'package:json_annotation/json_annotation.dart';

part "user_history.g.dart";

@JsonSerializable()
class UserHistory
    {
         int id ;

         int customerId ;

         int landlordId ;

         DateTime timeStamp ;

         String comment ;

         int rating ;
         
    
  UserHistory({
    required this.id,
    required this.customerId,
    required this.landlordId,
    required this.timeStamp,
    required this.comment,
    required this.rating,
  });

  factory UserHistory.fromJson(Map<String, dynamic> json) => _$UserHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$UserHistoryToJson(this);
}
