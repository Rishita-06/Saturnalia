// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_form_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DyamicFormData _$DyamicFormDataFromJson(Map<String, dynamic> json) =>
    DyamicFormData(
      type: (json['type'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      data: FormType.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DyamicFormDataToJson(DyamicFormData instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'data': instance.data,
    };

FormType _$FormTypeFromJson(Map<String, dynamic> json) => FormType(
      title: json['title'] as String,
      maxLength: (json['maxLength'] as num?)?.toInt(),
      hint: json['hint'] as String? ?? '',
      maxLines: (json['maxLines'] as num?)?.toInt(),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => OptionFormType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FormTypeToJson(FormType instance) => <String, dynamic>{
      'title': instance.title,
      'hint': instance.hint,
      'maxLength': instance.maxLength,
      'maxLines': instance.maxLines,
      'options': instance.options,
    };

OptionFormType _$OptionFormTypeFromJson(Map<String, dynamic> json) =>
    OptionFormType(
      optionValue: json['optionValue'] as String,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$OptionFormTypeToJson(OptionFormType instance) =>
    <String, dynamic>{
      'optionValue': instance.optionValue,
      'id': instance.id,
    };
