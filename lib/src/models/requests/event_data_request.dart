import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/json_utils.dart';

part 'event_data_request.g.dart';

@JsonSerializable()
class EventDataRequest {
  @JsonKey(
    fromJson: timestampToDateTime,
    toJson: dateTimeToTimestamp,
  )
  final DateTime eventDate;
  final String description;
  final String imageUrl;
  final int location;
  final String title;
  final String tag;
  final String venue;
  final bool? hasTimeLine;

  const EventDataRequest({
    required this.description,
    required this.eventDate,
    required this.tag,
    required this.imageUrl,
    required this.location,
    required this.title,
    required this.venue,
    this.hasTimeLine,
  });

  factory EventDataRequest.fromJson(Map<String, dynamic> json) =>
      _$EventDataRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EventDataRequestToJson(this);
}
