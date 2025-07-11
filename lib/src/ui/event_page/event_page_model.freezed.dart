// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EventPageState {
  int get userBalance => throw _privateConstructorUsedError;
  EventUserData? get data => throw _privateConstructorUsedError;
  String get eventId => throw _privateConstructorUsedError;
  bool get isAttending => throw _privateConstructorUsedError;
  String get eventName => throw _privateConstructorUsedError;
  bool get isPreview => throw _privateConstructorUsedError;
  EventStatus get status => throw _privateConstructorUsedError;

  /// Create a copy of EventPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventPageStateCopyWith<EventPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventPageStateCopyWith<$Res> {
  factory $EventPageStateCopyWith(
          EventPageState value, $Res Function(EventPageState) then) =
      _$EventPageStateCopyWithImpl<$Res, EventPageState>;
  @useResult
  $Res call(
      {int userBalance,
      EventUserData? data,
      String eventId,
      bool isAttending,
      String eventName,
      bool isPreview,
      EventStatus status});
}

/// @nodoc
class _$EventPageStateCopyWithImpl<$Res, $Val extends EventPageState>
    implements $EventPageStateCopyWith<$Res> {
  _$EventPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userBalance = null,
    Object? data = freezed,
    Object? eventId = null,
    Object? isAttending = null,
    Object? eventName = null,
    Object? isPreview = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      userBalance: null == userBalance
          ? _value.userBalance
          : userBalance // ignore: cast_nullable_to_non_nullable
              as int,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as EventUserData?,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      isAttending: null == isAttending
          ? _value.isAttending
          : isAttending // ignore: cast_nullable_to_non_nullable
              as bool,
      eventName: null == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String,
      isPreview: null == isPreview
          ? _value.isPreview
          : isPreview // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventPageStateImplCopyWith<$Res>
    implements $EventPageStateCopyWith<$Res> {
  factory _$$EventPageStateImplCopyWith(_$EventPageStateImpl value,
          $Res Function(_$EventPageStateImpl) then) =
      __$$EventPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int userBalance,
      EventUserData? data,
      String eventId,
      bool isAttending,
      String eventName,
      bool isPreview,
      EventStatus status});
}

/// @nodoc
class __$$EventPageStateImplCopyWithImpl<$Res>
    extends _$EventPageStateCopyWithImpl<$Res, _$EventPageStateImpl>
    implements _$$EventPageStateImplCopyWith<$Res> {
  __$$EventPageStateImplCopyWithImpl(
      _$EventPageStateImpl _value, $Res Function(_$EventPageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userBalance = null,
    Object? data = freezed,
    Object? eventId = null,
    Object? isAttending = null,
    Object? eventName = null,
    Object? isPreview = null,
    Object? status = null,
  }) {
    return _then(_$EventPageStateImpl(
      userBalance: null == userBalance
          ? _value.userBalance
          : userBalance // ignore: cast_nullable_to_non_nullable
              as int,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as EventUserData?,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      isAttending: null == isAttending
          ? _value.isAttending
          : isAttending // ignore: cast_nullable_to_non_nullable
              as bool,
      eventName: null == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String,
      isPreview: null == isPreview
          ? _value.isPreview
          : isPreview // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus,
    ));
  }
}

/// @nodoc

class _$EventPageStateImpl implements _EventPageState {
  const _$EventPageStateImpl(
      {this.userBalance = 0,
      this.data = null,
      this.eventId = '',
      this.isAttending = true,
      this.eventName = '',
      this.isPreview = false,
      this.status = EventStatus.initial});

  @override
  @JsonKey()
  final int userBalance;
  @override
  @JsonKey()
  final EventUserData? data;
  @override
  @JsonKey()
  final String eventId;
  @override
  @JsonKey()
  final bool isAttending;
  @override
  @JsonKey()
  final String eventName;
  @override
  @JsonKey()
  final bool isPreview;
  @override
  @JsonKey()
  final EventStatus status;

  @override
  String toString() {
    return 'EventPageState(userBalance: $userBalance, data: $data, eventId: $eventId, isAttending: $isAttending, eventName: $eventName, isPreview: $isPreview, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventPageStateImpl &&
            (identical(other.userBalance, userBalance) ||
                other.userBalance == userBalance) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.isAttending, isAttending) ||
                other.isAttending == isAttending) &&
            (identical(other.eventName, eventName) ||
                other.eventName == eventName) &&
            (identical(other.isPreview, isPreview) ||
                other.isPreview == isPreview) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userBalance, data, eventId,
      isAttending, eventName, isPreview, status);

  /// Create a copy of EventPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventPageStateImplCopyWith<_$EventPageStateImpl> get copyWith =>
      __$$EventPageStateImplCopyWithImpl<_$EventPageStateImpl>(
          this, _$identity);
}

abstract class _EventPageState implements EventPageState {
  const factory _EventPageState(
      {final int userBalance,
      final EventUserData? data,
      final String eventId,
      final bool isAttending,
      final String eventName,
      final bool isPreview,
      final EventStatus status}) = _$EventPageStateImpl;

  @override
  int get userBalance;
  @override
  EventUserData? get data;
  @override
  String get eventId;
  @override
  bool get isAttending;
  @override
  String get eventName;
  @override
  bool get isPreview;
  @override
  EventStatus get status;

  /// Create a copy of EventPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventPageStateImplCopyWith<_$EventPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
