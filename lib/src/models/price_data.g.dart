// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceData _$PriceDataFromJson(Map<String, dynamic> json) => PriceData(
      id: json['id'] as String,
      title: json['title'] as String,
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$PriceDataToJson(PriceData instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'value': instance.value,
    };
