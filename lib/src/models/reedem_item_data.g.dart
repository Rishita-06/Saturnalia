// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reedem_item_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReedemItemData _$ReedemItemDataFromJson(Map<String, dynamic> json) =>
    ReedemItemData(
      time: timestampToDateTime(json['time'] as Timestamp?),
      id: json['id'] as String,
      userName: json['userName'] as String,
      coins: (json['coins'] as num).toInt(),
      email: json['email'] as String,
      imageUrl: json['imageUrl'] as String,
      isGiven: json['isGiven'] as bool? ?? false,
      itemId: json['itemId'] as String,
      itemName: json['itemName'] as String,
      phone: (json['phone'] as num).toInt(),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$ReedemItemDataToJson(ReedemItemData instance) =>
    <String, dynamic>{
      'coins': instance.coins,
      'email': instance.email,
      'itemId': instance.itemId,
      'userId': instance.userId,
      'itemName': instance.itemName,
      'imageUrl': instance.imageUrl,
      'id': instance.id,
      'phone': instance.phone,
      'isGiven': instance.isGiven,
      'userName': instance.userName,
      'time': dateTimeToTimestamp(instance.time),
    };
