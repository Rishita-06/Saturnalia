import 'package:freezed_annotation/freezed_annotation.dart';

part 'leaderboard_data.g.dart';

@JsonSerializable()
class LeaderBoardData {
  final String userId;
  final String userName;
  final String email;
  final int gender;
  final int coins;
  LeaderBoardData({
    required this.userId,
    required this.userName,
    required this.email,
    required this.coins,
    required this.gender,
  });
  factory LeaderBoardData.fromJson(Map<String, dynamic> json) =>
      _$LeaderBoardDataFromJson(json);
}
