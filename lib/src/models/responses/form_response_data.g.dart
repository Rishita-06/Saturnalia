// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormResponseData _$FormResponseDataFromJson(Map<String, dynamic> json) =>
    FormResponseData(
      type: (json['type'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$FormResponseDataToJson(FormResponseData instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'title': instance.title,
      'value': instance.value,
    };
