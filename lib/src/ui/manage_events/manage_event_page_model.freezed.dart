// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_event_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ManageEventPageState {
  ManageEventPageStatus get status => throw _privateConstructorUsedError;

  /// Create a copy of ManageEventPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ManageEventPageStateCopyWith<ManageEventPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManageEventPageStateCopyWith<$Res> {
  factory $ManageEventPageStateCopyWith(ManageEventPageState value,
          $Res Function(ManageEventPageState) then) =
      _$ManageEventPageStateCopyWithImpl<$Res, ManageEventPageState>;
  @useResult
  $Res call({ManageEventPageStatus status});
}

/// @nodoc
class _$ManageEventPageStateCopyWithImpl<$Res,
        $Val extends ManageEventPageState>
    implements $ManageEventPageStateCopyWith<$Res> {
  _$ManageEventPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ManageEventPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ManageEventPageStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ManageEventPageStateImplCopyWith<$Res>
    implements $ManageEventPageStateCopyWith<$Res> {
  factory _$$ManageEventPageStateImplCopyWith(_$ManageEventPageStateImpl value,
          $Res Function(_$ManageEventPageStateImpl) then) =
      __$$ManageEventPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ManageEventPageStatus status});
}

/// @nodoc
class __$$ManageEventPageStateImplCopyWithImpl<$Res>
    extends _$ManageEventPageStateCopyWithImpl<$Res, _$ManageEventPageStateImpl>
    implements _$$ManageEventPageStateImplCopyWith<$Res> {
  __$$ManageEventPageStateImplCopyWithImpl(_$ManageEventPageStateImpl _value,
      $Res Function(_$ManageEventPageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManageEventPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$ManageEventPageStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ManageEventPageStatus,
    ));
  }
}

/// @nodoc

class _$ManageEventPageStateImpl implements _ManageEventPageState {
  const _$ManageEventPageStateImpl(
      {this.status = ManageEventPageStatus.initial});

  @override
  @JsonKey()
  final ManageEventPageStatus status;

  @override
  String toString() {
    return 'ManageEventPageState(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ManageEventPageStateImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of ManageEventPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ManageEventPageStateImplCopyWith<_$ManageEventPageStateImpl>
      get copyWith =>
          __$$ManageEventPageStateImplCopyWithImpl<_$ManageEventPageStateImpl>(
              this, _$identity);
}

abstract class _ManageEventPageState implements ManageEventPageState {
  const factory _ManageEventPageState({final ManageEventPageStatus status}) =
      _$ManageEventPageStateImpl;

  @override
  ManageEventPageStatus get status;

  /// Create a copy of ManageEventPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ManageEventPageStateImplCopyWith<_$ManageEventPageStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
