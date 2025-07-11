// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_us_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactUsData _$ContactUsDataFromJson(Map<String, dynamic> json) =>
    ContactUsData(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      eventId: json['eventId'] as String,
      mobile: (json['mobile'] as num).toInt(),
      issue: json['issue'] as bool? ?? false,
      description: json['description'] as String,
      time: timestampToDateTime(json['time'] as Timestamp?),
    );

Map<String, dynamic> _$ContactUsDataToJson(ContactUsData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'email': instance.email,
      'mobile': instance.mobile,
      'issue': instance.issue,
      'eventId': instance.eventId,
      'description': instance.description,
      'time': dateTimeToTimestamp(instance.time),
    };
