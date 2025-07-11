// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventUserData _$EventUserDataFromJson(Map<String, dynamic> json) =>
    EventUserData(
      userId: json['userId'] as String,
      isVerified: json['isVerified'] as bool,
      tokenId: json['tokenId'] as String,
      name: json['name'] as String,
      isAttending: json['isAttending'] as bool? ?? true,
      teamDetails: (json['teamDetails'] as List<dynamic>?)
          ?.map((e) => TeamDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentStatus: json['paymentStatus'] as bool? ?? false,
      mobile: (json['mobile'] as num?)?.toInt() ?? 0,
      collegeAddress: json['collegeAddress'] as String? ?? '',
      verificationTime:
          timestampToDateTime(json['verificationTime'] as Timestamp?),
      formResponse: (json['formResponse'] as List<dynamic>?)
          ?.map((e) => FormResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      verifiedBy: json['verifiedBy'] as String?,
      email: json['email'] as String?,
      userEmail: json['userEmail'] as String? ?? '',
    );

Map<String, dynamic> _$EventUserDataToJson(EventUserData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'tokenId': instance.tokenId,
      'isVerified': instance.isVerified,
      'name': instance.name,
      'collegeAddress': instance.collegeAddress,
      'isAttending': instance.isAttending,
      'paymentStatus': instance.paymentStatus,
      'mobile': instance.mobile,
      'verifiedBy': instance.verifiedBy,
      'teamDetails': instance.teamDetails,
      'formResponse': instance.formResponse,
      'verificationTime': dateTimeToTimestamp(instance.verificationTime),
      'email': instance.email,
      'userEmail': instance.userEmail,
    };
