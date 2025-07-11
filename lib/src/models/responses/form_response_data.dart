// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';
part 'form_response_data.g.dart';

@JsonSerializable()
class FormResponseData {
  final int type;
  final int id;
  final String title;
  final String value;

  const FormResponseData({
    required this.type,
    required this.id,
    required this.title,
    required this.value,
  });

  factory FormResponseData.fromJson(Map<String, dynamic> json) =>
      _$FormResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$FormResponseDataToJson(this);

  FormResponseData copyWith({
    int? type,
    int? id,
    String? title,
    String? value,
  }) {
    return FormResponseData(
      type: type ?? this.type,
      id: id ?? this.id,
      title: title ?? this.title,
      value: value ?? this.value,
    );
  }
}
