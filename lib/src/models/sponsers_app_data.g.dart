// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsers_app_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SponserAppData _$SponserAppDataFromJson(Map<String, dynamic> json) =>
    SponserAppData(
      androidPackageName: json['androidPackageName'] as String,
      appName: json['appName'] as String,
      iosPackageName: json['iosPackageName'] as String,
    );

Map<String, dynamic> _$SponserAppDataToJson(SponserAppData instance) =>
    <String, dynamic>{
      'androidPackageName': instance.androidPackageName,
      'iosPackageName': instance.iosPackageName,
      'appName': instance.appName,
    };
