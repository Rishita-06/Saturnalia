import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_utils.dart';

part 'reward_data.g.dart';

@JsonSerializable()
class RewardData {
  final String title;
  final String? description;
  final String id;
  final bool isPublic;
  final int itemLeft;
  final bool isExclusive;
  final int coins;
  final String imageUrl;
  final int originalValue;
  final int offerCoins;
  @JsonKey(
    fromJson: timestampToDateTime,
    toJson: dateTimeToTimestamp,
  )
  final DateTime date;

  const RewardData({
    required this.date,
    required this.id,
    this.description,
    this.isPublic = false,
    required this.coins,
    required this.itemLeft,
    required this.isExclusive,
    required this.offerCoins,
    required this.imageUrl,
    required this.originalValue,
    required this.title,
  });

  factory RewardData.fromJson(Map<String, dynamic> json) =>
      _$RewardDataFromJson(json);
  Map<String, dynamic> toJson() => _$RewardDataToJson(this);
}
