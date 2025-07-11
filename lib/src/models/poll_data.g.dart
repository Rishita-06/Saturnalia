// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollData _$PollDataFromJson(Map<String, dynamic> json) => PollData(
      coins: (json['coins'] as num).toInt(),
      creationTime: timestampToDateTime(json['creationTime'] as Timestamp?),
      id: json['id'] as String,
      pollEndTime: timestampToDateTime(json['pollEndTime'] as Timestamp?),
      pollStartTime: timestampToDateTime(json['pollStartTime'] as Timestamp?),
      subTitle: json['subTitle'] as String,
      title: json['title'] as String,
      isPublic: json['isPublic'] as bool? ?? false,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PollDataToJson(PollData instance) => <String, dynamic>{
      'id': instance.id,
      'creationTime': dateTimeToTimestamp(instance.creationTime),
      'pollStartTime': dateTimeToTimestamp(instance.pollStartTime),
      'pollEndTime': dateTimeToTimestamp(instance.pollEndTime),
      'title': instance.title,
      'subTitle': instance.subTitle,
      'isPublic': instance.isPublic,
      'coins': instance.coins,
      'options': instance.options,
    };
