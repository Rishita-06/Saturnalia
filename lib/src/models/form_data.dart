import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:Saturnalia/src/models/dynamic_form_data.dart';

import '../utils/json_utils.dart';

part 'form_data.g.dart';

@JsonSerializable()
class FormData {
  @JsonKey(
    fromJson: timestampToDateTime,
    toJson: dateTimeToTimestamp,
  )
  final DateTime startDate;
  @JsonKey(
    fromJson: timestampToDateTime,
    toJson: dateTimeToTimestamp,
  )
  final DateTime endDate;
  final int teamMinSize;
  final int teamMaxSize;

  final List<DyamicFormData> data;

  const FormData({
    required this.endDate,
    required this.startDate,
    this.teamMinSize = 1,
    this.teamMaxSize = 1,
    this.data = const [],
  });

  factory FormData.fromJson(Map<String, dynamic> json) =>
      _$FormDataFromJson(json);
  Map<String, dynamic> toJson() => _$FormDataToJson(this);
}
