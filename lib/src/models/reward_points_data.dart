import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_utils.dart';

part 'reward_points_data.g.dart';

@JsonSerializable()
class RewardPointsData {
  final String title;
  final String message;
  final String id;
  final int isAwarded;
  final int coins;
  @JsonKey(
    fromJson: timestampToDateTime,
    toJson: dateTimeToTimestamp,
  )
  final DateTime date;

  const RewardPointsData({
    required this.date,
    required this.message,
    required this.id,
    required this.coins,
    required this.isAwarded,
    required this.title,
  });

  factory RewardPointsData.fromJson(Map<String, dynamic> json) =>
      _$RewardPointsDataFromJson(json);
  Map<String, dynamic> toJson() => _$RewardPointsDataToJson(this);
}
