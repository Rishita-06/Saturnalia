// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_line_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeLineData _$TimeLineDataFromJson(Map<String, dynamic> json) => TimeLineData(
      description: json['description'] as String,
      eventDate: timestampToDateTime(json['eventDate'] as Timestamp?),
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$TimeLineDataToJson(TimeLineData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'id': instance.id,
      'eventDate': dateTimeToTimestamp(instance.eventDate),
    };
