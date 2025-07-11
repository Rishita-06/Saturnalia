import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_utils.dart';

part 'event_data.g.dart';

@JsonSerializable()
class EventData {
  @JsonKey(
    fromJson: timestampToDateTime,
    toJson: dateTimeToTimestamp,
  )
  final DateTime eventDate;
  @JsonKey(
    fromJson: timestampToDateTime,
    toJson: dateTimeToTimestamp,
  )
  final DateTime? eventEndDate;
  final String description;
  final String eventId;
  final String? imageUrl;
  final int? location;
  final String title;
  final String tag;
  final String pointOfContact;
  final String venue;
  final List<String>? link;
  final bool scanningStarted;
  final String rulesAndRegulation;
  final String registrationProcess;
  final String termsAndCondition;
  final int hasFormData;

  const EventData({
    required this.description,
    required this.eventDate,
    required this.tag,
    required this.eventId,
    this.imageUrl,
    this.hasFormData = 3,
    this.location,
    this.pointOfContact = '',
    this.rulesAndRegulation = '',
    this.registrationProcess = '',
    this.termsAndCondition = '',
    required this.title,
    required this.venue,
    this.link,
    this.eventEndDate,
    this.scanningStarted = false,
  });

  factory EventData.fromJson(Map<String, dynamic> json) =>
      _$EventDataFromJson(json);
  Map<String, dynamic> toJson() => _$EventDataToJson(this);
}
