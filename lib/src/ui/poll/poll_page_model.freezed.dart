// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PollPageState {
  PollPageStatus get status => throw _privateConstructorUsedError;
  List<PollData>? get polls => throw _privateConstructorUsedError;

  /// Create a copy of PollPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PollPageStateCopyWith<PollPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollPageStateCopyWith<$Res> {
  factory $PollPageStateCopyWith(
          PollPageState value, $Res Function(PollPageState) then) =
      _$PollPageStateCopyWithImpl<$Res, PollPageState>;
  @useResult
  $Res call({PollPageStatus status, List<PollData>? polls});
}

/// @nodoc
class _$PollPageStateCopyWithImpl<$Res, $Val extends PollPageState>
    implements $PollPageStateCopyWith<$Res> {
  _$PollPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PollPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? polls = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PollPageStatus,
      polls: freezed == polls
          ? _value.polls
          : polls // ignore: cast_nullable_to_non_nullable
              as List<PollData>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PollPageStateImplCopyWith<$Res>
    implements $PollPageStateCopyWith<$Res> {
  factory _$$PollPageStateImplCopyWith(
          _$PollPageStateImpl value, $Res Function(_$PollPageStateImpl) then) =
      __$$PollPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PollPageStatus status, List<PollData>? polls});
}

/// @nodoc
class __$$PollPageStateImplCopyWithImpl<$Res>
    extends _$PollPageStateCopyWithImpl<$Res, _$PollPageStateImpl>
    implements _$$PollPageStateImplCopyWith<$Res> {
  __$$PollPageStateImplCopyWithImpl(
      _$PollPageStateImpl _value, $Res Function(_$PollPageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PollPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? polls = freezed,
  }) {
    return _then(_$PollPageStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PollPageStatus,
      polls: freezed == polls
          ? _value._polls
          : polls // ignore: cast_nullable_to_non_nullable
              as List<PollData>?,
    ));
  }
}

/// @nodoc

class _$PollPageStateImpl implements _PollPageState {
  const _$PollPageStateImpl(
      {this.status = PollPageStatus.initial,
      final List<PollData>? polls = null})
      : _polls = polls;

  @override
  @JsonKey()
  final PollPageStatus status;
  final List<PollData>? _polls;
  @override
  @JsonKey()
  List<PollData>? get polls {
    final value = _polls;
    if (value == null) return null;
    if (_polls is EqualUnmodifiableListView) return _polls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PollPageState(status: $status, polls: $polls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollPageStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._polls, _polls));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_polls));

  /// Create a copy of PollPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PollPageStateImplCopyWith<_$PollPageStateImpl> get copyWith =>
      __$$PollPageStateImplCopyWithImpl<_$PollPageStateImpl>(this, _$identity);
}

abstract class _PollPageState implements PollPageState {
  const factory _PollPageState(
      {final PollPageStatus status,
      final List<PollData>? polls}) = _$PollPageStateImpl;

  @override
  PollPageStatus get status;
  @override
  List<PollData>? get polls;

  /// Create a copy of PollPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PollPageStateImplCopyWith<_$PollPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
