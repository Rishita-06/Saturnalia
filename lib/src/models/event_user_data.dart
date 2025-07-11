import 'package:Saturnalia/src/models/responses/form_response_data.dart';
import 'package:Saturnalia/src/models/responses/team_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/src/utils/json_utils.dart';

part 'event_user_data.g.dart';

@JsonSerializable()
class EventUserData {
  final String userId;
  final String tokenId;
  final bool isVerified;
  final String name;
  final String collegeAddress;
  final bool isAttending;
  final bool paymentStatus;
  final int mobile;
  final String? verifiedBy;
  final List<TeamDetails>? teamDetails;
  final List<FormResponseData>? formResponse;
  @JsonKey(
    fromJson: timestampToDateTime,
    toJson: dateTimeToTimestamp,
  )
  final DateTime? verificationTime;

  final String? email;
  final String userEmail;

  const EventUserData({
    required this.userId,
    required this.isVerified,
    required this.tokenId,
    required this.name,
    this.isAttending = true,
    this.teamDetails,
    this.paymentStatus = false,
    this.mobile = 0,
    this.collegeAddress = '',
    this.verificationTime,
    this.formResponse,
    this.verifiedBy,
    this.email,
    this.userEmail = '',
  });

  factory EventUserData.fromJson(Map<String, dynamic> json) =>
      _$EventUserDataFromJson(json);
  Map<String, dynamic> toJson() => _$EventUserDataToJson(this);
}
