import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_data.g.dart';

@JsonSerializable()
class NotificationData {
  final String title;
  final String message;
  final int id;

  final String date;

  const NotificationData({
    required this.date,
    required this.message,
    required this.id,
    required this.title,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);
}
