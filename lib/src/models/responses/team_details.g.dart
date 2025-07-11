// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamDetails _$TeamDetailsFromJson(Map<String, dynamic> json) => TeamDetails(
      id: (json['id'] as num).toInt(),
      userId: json['userId'] as String,
      collegeAddress: json['collegeAddress'] as String,
      email: json['email'] as String,
      year: json['year'] as String? ?? '',
      name: json['name'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$TeamDetailsToJson(TeamDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'year': instance.year,
      'collegeAddress': instance.collegeAddress,
    };
