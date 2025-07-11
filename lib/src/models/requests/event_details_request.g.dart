// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_details_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDetailsRequest _$EventDetailsRequestFromJson(Map<String, dynamic> json) =>
    EventDetailsRequest(
      details:
          EventDataRequest.fromJson(json['details'] as Map<String, dynamic>),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      timeLineData: (json['timeLineData'] as List<dynamic>?)
          ?.map((e) => TimeLineData.fromJson(e as Map<String, dynamic>))
          .toList(),
      formData: json['formData'] == null
          ? null
          : FormData.fromJson(json['formData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventDetailsRequestToJson(
        EventDetailsRequest instance) =>
    <String, dynamic>{
      'details': instance.details,
      'images': instance.images,
      'timeLineData': instance.timeLineData,
      'formData': instance.formData,
    };
