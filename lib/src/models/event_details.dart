import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:Saturnalia/src/models/time_line_data.dart';

import 'event_data.dart';
import 'form_data.dart';
import 'price_data.dart';

part 'event_details.g.dart';

@JsonSerializable()
class EventDetails {
  final EventData details;
  final bool? isPublic;
  final List<String>? editors;
  final bool isFeatured;
  final bool isInformal;
  final List<String> images;
  final List<PriceData>? priceData;
  final List<TimeLineData>? timeLineData;
  final int eventVisibility;
  final int registrationType;
  final FormData? formData;

  const EventDetails({
    required this.details,
    this.isPublic,
    required this.images,
    this.timeLineData,
    this.editors,
    this.isInformal = false,
    this.isFeatured = false,
    this.priceData,
    this.formData,
    this.eventVisibility = 1,
    this.registrationType = 1,
  });

  factory EventDetails.fromJson(Map<String, dynamic> json) =>
      _$EventDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailsToJson(this);
}
