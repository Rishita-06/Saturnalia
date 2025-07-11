// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'events_map_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EventPageState {
  int get userBalance => throw _privateConstructorUsedError;
  geo.GeoPoint? get geoPoint => throw _privateConstructorUsedError;
  List<EventDetails>? get eventList => throw _privateConstructorUsedError;

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
      {int userBalance, geo.GeoPoint? geoPoint, List<EventDetails>? eventList});
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
    Object? geoPoint = freezed,
    Object? eventList = freezed,
  }) {
    return _then(_value.copyWith(
      userBalance: null == userBalance
          ? _value.userBalance
          : userBalance // ignore: cast_nullable_to_non_nullable
              as int,
      geoPoint: freezed == geoPoint
          ? _value.geoPoint
          : geoPoint // ignore: cast_nullable_to_non_nullable
              as geo.GeoPoint?,
      eventList: freezed == eventList
          ? _value.eventList
          : eventList // ignore: cast_nullable_to_non_nullable
              as List<EventDetails>?,
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
      {int userBalance, geo.GeoPoint? geoPoint, List<EventDetails>? eventList});
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
    Object? geoPoint = freezed,
    Object? eventList = freezed,
  }) {
    return _then(_$EventPageStateImpl(
      userBalance: null == userBalance
          ? _value.userBalance
          : userBalance // ignore: cast_nullable_to_non_nullable
              as int,
      geoPoint: freezed == geoPoint
          ? _value.geoPoint
          : geoPoint // ignore: cast_nullable_to_non_nullable
              as geo.GeoPoint?,
      eventList: freezed == eventList
          ? _value._eventList
          : eventList // ignore: cast_nullable_to_non_nullable
              as List<EventDetails>?,
    ));
  }
}

/// @nodoc

class _$EventPageStateImpl implements _EventPageState {
  const _$EventPageStateImpl(
      {this.userBalance = 0,
      this.geoPoint = null,
      final List<EventDetails>? eventList = null})
      : _eventList = eventList;

  @override
  @JsonKey()
  final int userBalance;
  @override
  @JsonKey()
  final geo.GeoPoint? geoPoint;
  final List<EventDetails>? _eventList;
  @override
  @JsonKey()
  List<EventDetails>? get eventList {
    final value = _eventList;
    if (value == null) return null;
    if (_eventList is EqualUnmodifiableListView) return _eventList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'EventPageState(userBalance: $userBalance, geoPoint: $geoPoint, eventList: $eventList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventPageStateImpl &&
            (identical(other.userBalance, userBalance) ||
                other.userBalance == userBalance) &&
            (identical(other.geoPoint, geoPoint) ||
                other.geoPoint == geoPoint) &&
            const DeepCollectionEquality()
                .equals(other._eventList, _eventList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userBalance, geoPoint,
      const DeepCollectionEquality().hash(_eventList));

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
      final geo.GeoPoint? geoPoint,
      final List<EventDetails>? eventList}) = _$EventPageStateImpl;

  @override
  int get userBalance;
  @override
  geo.GeoPoint? get geoPoint;
  @override
  List<EventDetails>? get eventList;

  /// Create a copy of EventPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventPageStateImplCopyWith<_$EventPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
