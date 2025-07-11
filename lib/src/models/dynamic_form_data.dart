// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamic_form_data.g.dart';

@JsonSerializable()
class DyamicFormData {
  final int type;
  final int id;
  final FormType data;

  const DyamicFormData({
    required this.type,
    required this.id,
    required this.data,
  });

  factory DyamicFormData.fromJson(Map<String, dynamic> json) =>
      _$DyamicFormDataFromJson(json);

  Map<String, dynamic> toJson() => _$DyamicFormDataToJson(this);

  DyamicFormData copyWith({
    int? type,
    int? id,
    FormType? data,
  }) {
    return DyamicFormData(
      type: type ?? this.type,
      id: id ?? this.id,
      data: data ?? this.data,
    );
  }
}

@JsonSerializable()
class FormType {
  final String title;
  final String hint;
  final int? maxLength;
  final int? maxLines;
  final List<OptionFormType>? options;

  const FormType({
    required this.title,
    this.maxLength,
    this.hint = '',
    this.maxLines,
    this.options,
  });

  factory FormType.fromJson(Map<String, dynamic> json) =>
      _$FormTypeFromJson(json);

  Map<String, dynamic> toJson() => _$FormTypeToJson(this);

  FormType copyWith({
    String? title,
    int? maxLength,
    int? maxLines,
    List<OptionFormType>? options,
  }) {
    return FormType(
      title: title ?? this.title,
      maxLength: maxLength ?? this.maxLength,
      maxLines: maxLines ?? this.maxLines,
      options: options ?? this.options,
    );
  }
}

@JsonSerializable()
class OptionFormType {
  final String optionValue;
  final int id;

  const OptionFormType({
    required this.optionValue,
    required this.id,
  });

  factory OptionFormType.fromJson(Map<String, dynamic> json) =>
      _$OptionFormTypeFromJson(json);

  Map<String, dynamic> toJson() => _$OptionFormTypeToJson(this);

  OptionFormType copyWith({
    String? optionValue,
    int? id,
  }) {
    return OptionFormType(
      optionValue: optionValue ?? this.optionValue,
      id: id ?? this.id,
    );
  }
}
