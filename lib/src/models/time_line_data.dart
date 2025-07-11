import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_utils.dart';

part 'time_line_data.g.dart';

@JsonSerializable()
class TimeLineData {
  final String title;
  final String description;
  final int id;
  @JsonKey(
    fromJson: timestampToDateTime,
    toJson: dateTimeToTimestamp,
  )
  final DateTime? eventDate;

  const TimeLineData({
    required this.description,
    required this.eventDate,
    required this.id,
    required this.title,
  });

  factory TimeLineData.fromJson(Map<String, dynamic> json) =>
      _$TimeLineDataFromJson(json);
  Map<String, dynamic> toJson() => _$TimeLineDataToJson(this);
}
