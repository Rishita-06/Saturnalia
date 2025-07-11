import 'package:freezed_annotation/freezed_annotation.dart';

part 'sponsers_app_data.g.dart';

@JsonSerializable()
class SponserAppData {
  final String androidPackageName;
  final String iosPackageName;
  final String appName;

  const SponserAppData({
    required this.androidPackageName,
    required this.appName,
    required this.iosPackageName,
  });

  factory SponserAppData.fromJson(Map<String, dynamic> json) =>
      _$SponserAppDataFromJson(json);
}
