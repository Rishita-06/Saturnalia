// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardData _$RewardDataFromJson(Map<String, dynamic> json) => RewardData(
      date: timestampToDateTime(json['date'] as Timestamp?),
      id: json['id'] as String,
      description: json['description'] as String?,
      isPublic: json['isPublic'] as bool? ?? false,
      coins: (json['coins'] as num).toInt(),
      itemLeft: (json['itemLeft'] as num).toInt(),
      isExclusive: json['isExclusive'] as bool,
      offerCoins: (json['offerCoins'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      originalValue: (json['originalValue'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$RewardDataToJson(RewardData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'id': instance.id,
      'isPublic': instance.isPublic,
      'itemLeft': instance.itemLeft,
      'isExclusive': instance.isExclusive,
      'coins': instance.coins,
      'imageUrl': instance.imageUrl,
      'originalValue': instance.originalValue,
      'offerCoins': instance.offerCoins,
      'date': dateTimeToTimestamp(instance.date),
    };
