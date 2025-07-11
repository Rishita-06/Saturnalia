import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_utils.dart';

part 'poll_data.g.dart';

@JsonSerializable()
class PollData {
  final String id;

  @JsonKey(
    fromJson: timestampToDateTime,
    toJson: dateTimeToTimestamp,
  )
  final DateTime creationTime;
  @JsonKey(
    fromJson: timestampToDateTime,
    toJson: dateTimeToTimestamp,
  )
  final DateTime pollStartTime;

  @JsonKey(
    fromJson: timestampToDateTime,
    toJson: dateTimeToTimestamp,
  )
  final DateTime pollEndTime;
  final String title;
  final String subTitle;
  final bool isPublic;
  final int coins;
  final List<String> options;

  const PollData({
    required this.coins,
    required this.creationTime,
    required this.id,
    required this.pollEndTime,
    required this.pollStartTime,
    required this.subTitle,
    required this.title,
    this.isPublic = false,
    required this.options,
  });

  factory PollData.fromJson(Map<String, dynamic> json) =>
      _$PollDataFromJson(json);
  Map<String, dynamic> toJson() => _$PollDataToJson(this);
}
