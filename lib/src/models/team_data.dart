import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_data.g.dart';

@JsonSerializable()
class TeamData {
  final String userId;
  final String userName;
  final String email;
  final String graduationYear;
  final int gender;
  final int coins;
  final int phoneNumber;
  final int roleId;

  final List<String>? events;

  const TeamData({
    required this.userId,
    required this.userName,
    required this.email,
    required this.graduationYear,
    required this.phoneNumber,
    required this.gender,
    required this.coins,
    required this.roleId,
    this.events,
  });

  factory TeamData.fromJson(Map<String, dynamic> json) =>
      _$TeamDataFromJson(json);
  Map<String, dynamic> toJson() => _$TeamDataToJson(this);
}

@JsonSerializable()
class ProfileData {
  final String userId;
  final String userName;
  final String email;
  final String graduationYear;
  final int gender;
  final String position;

  const ProfileData({
    required this.userId,
    required this.userName,
    required this.email,
    required this.graduationYear,
    required this.position,
    required this.gender,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}
