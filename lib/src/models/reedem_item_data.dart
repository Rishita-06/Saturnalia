import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_utils.dart';

part 'reedem_item_data.g.dart';

@JsonSerializable()
class ReedemItemData {
  final int coins;
  final String email;
  final String itemId;
  final String userId;
  final String itemName;
  final String imageUrl;
  final String id;
  final int phone;
  final bool isGiven;
  final String userName;

  @JsonKey(
    fromJson: timestampToDateTime,
    toJson: dateTimeToTimestamp,
  )
  final DateTime time;

  const ReedemItemData({
    required this.time,
    required this.id,
    required this.userName,
    required this.coins,
    required this.email,
    required this.imageUrl,
    this.isGiven = false,
    required this.itemId,
    required this.itemName,
    required this.phone,
    required this.userId,
  });

  factory ReedemItemData.fromJson(Map<String, dynamic> json) =>
      _$ReedemItemDataFromJson(json);
  Map<String, dynamic> toJson() => _$ReedemItemDataToJson(this);
}
