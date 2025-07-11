// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_points_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardPointsData _$RewardPointsDataFromJson(Map<String, dynamic> json) =>
    RewardPointsData(
      date: timestampToDateTime(json['date'] as Timestamp?),
      message: json['message'] as String,
      id: json['id'] as String,
      coins: (json['coins'] as num).toInt(),
      isAwarded: (json['isAwarded'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$RewardPointsDataToJson(RewardPointsData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
      'id': instance.id,
      'isAwarded': instance.isAwarded,
      'coins': instance.coins,
      'date': dateTimeToTimestamp(instance.date),
    };
