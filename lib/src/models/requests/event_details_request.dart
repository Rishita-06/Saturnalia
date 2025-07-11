import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:Saturnalia/src/models/time_line_data.dart';

import '../form_data.dart';
import 'event_data_request.dart';

part 'event_details_request.g.dart';

@JsonSerializable()
class EventDetailsRequest {
  final EventDataRequest details;
  final List<String> images;
  final List<TimeLineData>? timeLineData;
  final FormData? formData;

  const EventDetailsRequest({
    required this.details,
    required this.images,
    this.timeLineData,
    this.formData,
  });

  factory EventDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$EventDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailsRequestToJson(this);
}
