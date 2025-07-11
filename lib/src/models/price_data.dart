import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_data.g.dart';

@JsonSerializable()
class PriceData {
  final String id;
  final String title;
  final int value;

  const PriceData({
    required this.id,
    required this.title,
    required this.value,
  });

  factory PriceData.fromJson(Map<String, dynamic> json) =>
      _$PriceDataFromJson(json);
  Map<String, dynamic> toJson() => _$PriceDataToJson(this);
}
