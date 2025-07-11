import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_utils.dart';

part 'contact_us_data.g.dart';

@JsonSerializable()
class ContactUsData {
  final String userId;
  final String userName;
  final String email;
  final int mobile;
  final bool issue;
  final String eventId;
  final String description;
  @JsonKey(
    fromJson: timestampToDateTime,
    toJson: dateTimeToTimestamp,
  )
  final DateTime time;
  ContactUsData({
    required this.userId,
    required this.userName,
    required this.email,
    required this.eventId,
    required this.mobile,
    this.issue=false,
    required this.description,
    required this.time,
  });
  factory ContactUsData.fromJson(Map<String, dynamic> json) =>
      _$ContactUsDataFromJson(json);
  Map<String,dynamic> toJson()=> _$ContactUsDataToJson(this);
}