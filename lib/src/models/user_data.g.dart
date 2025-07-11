// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      profilePicUrl: json['profilePicUrl'] as String,
      collegeCity: json['collegeCity'] as String,
      collegeName: json['collegeName'] as String,
      collegePinCode: (json['collegePinCode'] as num).toInt(),
      collegeState: json['collegeState'] as String,
      graduationYear: json['graduationYear'] as String,
      referalCode: json['referalCode'] as String,
      branch: json['branch'] as String,
      phoneNumber: (json['phoneNumber'] as num).toInt(),
      gender: (json['gender'] as num).toInt(),
      uniqueId: json['uniqueId'] as String,
      rollNumber: (json['rollNumber'] as num?)?.toInt(),
      coins: (json['coins'] as num).toInt(),
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      isAdmin: json['isAdmin'] as bool? ?? false,
      events:
          (json['events'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic> {
      'userId': instance.userId,
      'userName': instance.userName,
      'email': instance.email,
      'profilePicUrl': instance.profilePicUrl,
      'graduationYear': instance.graduationYear,
      'gender': instance.gender,
      'collegeName': instance.collegeName,
      'collegeCity': instance.collegeCity,
      'collegeState': instance.collegeState,
      'branch': instance.branch,
      'coins': instance.coins,
      'collegePinCode': instance.collegePinCode,
      'referalCode': instance.referalCode,
      'uniqueId': instance.uniqueId,
      'phoneNumber': instance.phoneNumber,
      'rollNumber': instance.rollNumber,
      'isAdmin': instance.isAdmin,
      'events': instance.events,
      'roles': instance.roles,
    };
