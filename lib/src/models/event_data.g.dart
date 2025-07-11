// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventData _$EventDataFromJson(Map<String, dynamic> json) => EventData(
      description: json['description'] as String,
      eventDate: timestampToDateTime(json['eventDate'] as Timestamp?),
      tag: json['tag'] as String,
      eventId: json['eventId'] as String,
      imageUrl: json['imageUrl'] as String?,
      hasFormData: (json['hasFormData'] as num?)?.toInt() ?? 3,
      location: (json['location'] as num?)?.toInt(),
      pointOfContact: json['pointOfContact'] as String? ?? '',
      rulesAndRegulation: json['rulesAndRegulation'] as String? ?? '',
      registrationProcess: json['registrationProcess'] as String? ?? '',
      termsAndCondition: json['termsAndCondition'] as String? ?? '',
      title: json['title'] as String,
      venue: json['venue'] as String,
      link: (json['link'] as List<dynamic>?)?.map((e) => e as String).toList(),
      eventEndDate: timestampToDateTime(json['eventEndDate'] as Timestamp?),
      scanningStarted: json['scanningStarted'] as bool? ?? false,
    );

Map<String, dynamic> _$EventDataToJson(EventData instance) => <String, dynamic>{
      'eventDate': dateTimeToTimestamp(instance.eventDate),
      'eventEndDate': dateTimeToTimestamp(instance.eventEndDate),
      'description': instance.description,
      'eventId': instance.eventId,
      'imageUrl': instance.imageUrl,
      'location': instance.location,
      'title': instance.title,
      'tag': instance.tag,
      'pointOfContact': instance.pointOfContact,
      'venue': instance.venue,
      'link': instance.link,
      'scanningStarted': instance.scanningStarted,
      'rulesAndRegulation': instance.rulesAndRegulation,
      'registrationProcess': instance.registrationProcess,
      'termsAndCondition': instance.termsAndCondition,
      'hasFormData': instance.hasFormData,
    };
