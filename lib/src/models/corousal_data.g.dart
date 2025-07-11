// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corousal_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CorousalData _$CorousalDataFromJson(Map<String, dynamic> json) => CorousalData(
      id: json['id'] as String,
      date: timestampToDateTime(json['date'] as Timestamp?),
      isPublic: json['isPublic'] as bool?,
      corousalType: (json['corousalType'] as num?)?.toInt() ?? 0,
      eventId: json['eventId'] as String?,
      imageUrl: json['imageUrl'] as String,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$CorousalDataToJson(CorousalData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isPublic': instance.isPublic,
      'imageUrl': instance.imageUrl,
      'link': instance.link,
      'corousalType': instance.corousalType,
      'eventId': instance.eventId,
      'date': dateTimeToTimestamp(instance.date),
    };
