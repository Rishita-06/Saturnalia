// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDataRequest _$EventDataRequestFromJson(Map<String, dynamic> json) =>
    EventDataRequest(
      description: json['description'] as String,
      eventDate: timestampToDateTime(json['eventDate'] as Timestamp?),
      tag: json['tag'] as String,
      imageUrl: json['imageUrl'] as String,
      location: (json['location'] as num).toInt(),
      title: json['title'] as String,
      venue: json['venue'] as String,
      hasTimeLine: json['hasTimeLine'] as bool?,
    );

Map<String, dynamic> _$EventDataRequestToJson(EventDataRequest instance) =>
    <String, dynamic>{
      'eventDate': dateTimeToTimestamp(instance.eventDate),
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'location': instance.location,
      'title': instance.title,
      'tag': instance.tag,
      'venue': instance.venue,
      'hasTimeLine': instance.hasTimeLine,
    };
