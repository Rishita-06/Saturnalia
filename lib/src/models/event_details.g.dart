// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDetails _$EventDetailsFromJson(Map<String, dynamic> json) => EventDetails(
      details: EventData.fromJson(json['details'] as Map<String, dynamic>),
      isPublic: json['isPublic'] as bool?,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      timeLineData: (json['timeLineData'] as List<dynamic>?)
          ?.map((e) => TimeLineData.fromJson(e as Map<String, dynamic>))
          .toList(),
      editors:
          (json['editors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isInformal: json['isInformal'] as bool? ?? false,
      isFeatured: json['isFeatured'] as bool? ?? false,
      priceData: (json['priceData'] as List<dynamic>?)
          ?.map((e) => PriceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      formData: json['formData'] == null
          ? null
          : FormData.fromJson(json['formData'] as Map<String, dynamic>),
      eventVisibility: (json['eventVisibility'] as num?)?.toInt() ?? 1,
      registrationType: (json['registrationType'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$EventDetailsToJson(EventDetails instance) =>
    <String, dynamic>{
      'details': instance.details,
      'isPublic': instance.isPublic,
      'editors': instance.editors,
      'isFeatured': instance.isFeatured,
      'isInformal': instance.isInformal,
      'images': instance.images,
      'priceData': instance.priceData,
      'timeLineData': instance.timeLineData,
      'eventVisibility': instance.eventVisibility,
      'registrationType': instance.registrationType,
      'formData': instance.formData,
    };
