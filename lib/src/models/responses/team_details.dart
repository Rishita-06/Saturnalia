// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_details.g.dart';

@JsonSerializable()
class TeamDetails {
  final int id;
  final String title;
  final String userId;
  final String name;
  final String email;
  final String year;
  final String collegeAddress;

  const TeamDetails({
    required this.id,
    required this.userId,
    required this.collegeAddress,
    required this.email,
    this.year = '',
    required this.name,
    required this.title,
  });

  factory TeamDetails.fromJson(Map<String, dynamic> json) =>
      _$TeamDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TeamDetailsToJson(this);
}
