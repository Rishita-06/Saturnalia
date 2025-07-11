// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderBoardData _$LeaderBoardDataFromJson(Map<String, dynamic> json) =>
    LeaderBoardData(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      coins: (json['coins'] as num).toInt(),
      gender: (json['gender'] as num).toInt(),
    );

Map<String, dynamic> _$LeaderBoardDataToJson(LeaderBoardData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'email': instance.email,
      'gender': instance.gender,
      'coins': instance.coins,
    };
