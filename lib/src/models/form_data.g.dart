// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormData _$FormDataFromJson(Map<String, dynamic> json) => FormData(
      endDate: timestampToDateTime(json['endDate'] as Timestamp?),
      startDate: timestampToDateTime(json['startDate'] as Timestamp?),
      teamMinSize: (json['teamMinSize'] as num?)?.toInt() ?? 1,
      teamMaxSize: (json['teamMaxSize'] as num?)?.toInt() ?? 1,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => DyamicFormData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FormDataToJson(FormData instance) => <String, dynamic>{
      'startDate': dateTimeToTimestamp(instance.startDate),
      'endDate': dateTimeToTimestamp(instance.endDate),
      'teamMinSize': instance.teamMinSize,
      'teamMaxSize': instance.teamMaxSize,
      'data': instance.data,
    };
