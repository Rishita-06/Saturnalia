// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_us_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ContactUsPageState {
  ContactUsPageStatus get status => throw _privateConstructorUsedError;
  String? get issueTitle => throw _privateConstructorUsedError;
  ContactUsData? get data => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Create a copy of ContactUsPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactUsPageStateCopyWith<ContactUsPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactUsPageStateCopyWith<$Res> {
  factory $ContactUsPageStateCopyWith(
          ContactUsPageState value, $Res Function(ContactUsPageState) then) =
      _$ContactUsPageStateCopyWithImpl<$Res, ContactUsPageState>;
  @useResult
  $Res call(
      {ContactUsPageStatus status,
      String? issueTitle,
      ContactUsData? data,
      String description});
}

/// @nodoc
class _$ContactUsPageStateCopyWithImpl<$Res, $Val extends ContactUsPageState>
    implements $ContactUsPageStateCopyWith<$Res> {
  _$ContactUsPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactUsPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? issueTitle = freezed,
    Object? data = freezed,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ContactUsPageStatus,
      issueTitle: freezed == issueTitle
          ? _value.issueTitle
          : issueTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ContactUsData?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactUsPageStateImplCopyWith<$Res>
    implements $ContactUsPageStateCopyWith<$Res> {
  factory _$$ContactUsPageStateImplCopyWith(_$ContactUsPageStateImpl value,
          $Res Function(_$ContactUsPageStateImpl) then) =
      __$$ContactUsPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ContactUsPageStatus status,
      String? issueTitle,
      ContactUsData? data,
      String description});
}

/// @nodoc
class __$$ContactUsPageStateImplCopyWithImpl<$Res>
    extends _$ContactUsPageStateCopyWithImpl<$Res, _$ContactUsPageStateImpl>
    implements _$$ContactUsPageStateImplCopyWith<$Res> {
  __$$ContactUsPageStateImplCopyWithImpl(_$ContactUsPageStateImpl _value,
      $Res Function(_$ContactUsPageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContactUsPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? issueTitle = freezed,
    Object? data = freezed,
    Object? description = null,
  }) {
    return _then(_$ContactUsPageStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ContactUsPageStatus,
      issueTitle: freezed == issueTitle
          ? _value.issueTitle
          : issueTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ContactUsData?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ContactUsPageStateImpl implements _ContactUsPageState {
  const _$ContactUsPageStateImpl(
      {this.status = ContactUsPageStatus.initial,
      this.issueTitle = null,
      this.data = null,
      this.description = ''});

  @override
  @JsonKey()
  final ContactUsPageStatus status;
  @override
  @JsonKey()
  final String? issueTitle;
  @override
  @JsonKey()
  final ContactUsData? data;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'ContactUsPageState(status: $status, issueTitle: $issueTitle, data: $data, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactUsPageStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.issueTitle, issueTitle) ||
                other.issueTitle == issueTitle) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, issueTitle, data, description);

  /// Create a copy of ContactUsPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactUsPageStateImplCopyWith<_$ContactUsPageStateImpl> get copyWith =>
      __$$ContactUsPageStateImplCopyWithImpl<_$ContactUsPageStateImpl>(
          this, _$identity);
}

abstract class _ContactUsPageState implements ContactUsPageState {
  const factory _ContactUsPageState(
      {final ContactUsPageStatus status,
      final String? issueTitle,
      final ContactUsData? data,
      final String description}) = _$ContactUsPageStateImpl;

  @override
  ContactUsPageStatus get status;
  @override
  String? get issueTitle;
  @override
  ContactUsData? get data;
  @override
  String get description;

  /// Create a copy of ContactUsPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactUsPageStateImplCopyWith<_$ContactUsPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
