import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  final String userId;
  final String userName;
  final String email;
  final String profilePicUrl;
  final String graduationYear;
  final int gender;
  final String collegeName;
  final String collegeCity;
  final String collegeState;
  final String branch;
  final int coins;
  final int collegePinCode;
  final String referalCode;
  final String uniqueId;
  final int phoneNumber;
  final int? rollNumber;

  final bool isAdmin;
  final List<String>? events;
  final List<int>? roles;

  const UserData({
    required this.userId,
    required this.userName,
    required this.email,
    required this.profilePicUrl,
    required this.collegeCity,
    required this.collegeName,
    required this.collegePinCode,
    required this.collegeState,
    required this.graduationYear,
    required this.referalCode,
    required this.branch,
    required this.phoneNumber,
    required this.gender,
    required this.uniqueId,
    this.rollNumber,
    required this.coins,
    this.roles,
    this.isAdmin = false,
    this.events,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
