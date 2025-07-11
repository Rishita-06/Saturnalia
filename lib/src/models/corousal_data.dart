import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_utils.dart';

part 'corousal_data.g.dart';

@JsonSerializable()
class CorousalData {
  final String id;
  final bool? isPublic;
  final String imageUrl;
  final String? link;
  final int corousalType;
  final String? eventId;

  @JsonKey(
    fromJson: timestampToDateTime,
    toJson: dateTimeToTimestamp,
  )
  final DateTime date;

  const CorousalData({
    required this.id,
    required this.date,
    this.isPublic,
    this.corousalType = 0,
    required this.eventId,
    required this.imageUrl,
    required this.link,
  });

  factory CorousalData.fromJson(Map<String, dynamic> json) =>
      _$CorousalDataFromJson(json);
  Map<String, dynamic> toJson() => _$CorousalDataToJson(this);
}
