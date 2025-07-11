// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamData _$TeamDataFromJson(Map<String, dynamic> json) => TeamData(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      graduationYear: json['graduationYear'] as String,
      phoneNumber: (json['phoneNumber'] as num).toInt(),
      gender: (json['gender'] as num).toInt(),
      coins: (json['coins'] as num).toInt(),
      roleId: (json['roleId'] as num).toInt(),
      events:
          (json['events'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TeamDataToJson(TeamData instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'email': instance.email,
      'graduationYear': instance.graduationYear,
      'gender': instance.gender,
      'coins': instance.coins,
      'phoneNumber': instance.phoneNumber,
      'roleId': instance.roleId,
      'events': instance.events,
    };

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      graduationYear: json['graduationYear'] as String,
      position: json['position'] as String,
      gender: (json['gender'] as num).toInt(),
    );

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'email': instance.email,
      'graduationYear': instance.graduationYear,
      'gender': instance.gender,
      'position': instance.position,
    };
