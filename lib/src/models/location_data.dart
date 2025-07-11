import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_data.g.dart';

@JsonSerializable()
class LocationData {
  final double latitude;
  final double longitude;
  final int id;
  final String venue;

  const LocationData({
    required this.latitude,
    required this.longitude,
    required this.venue,
    required this.id,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) =>
      _$LocationDataFromJson(json);
  Map<String, dynamic> toJson() => _$LocationDataToJson(this);
}
