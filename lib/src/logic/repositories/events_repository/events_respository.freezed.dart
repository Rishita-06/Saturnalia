// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'events_respository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EventsPageState {
  int get userBalance => throw _privateConstructorUsedError;
  List<LocationData>? get locationData => throw _privateConstructorUsedError;
  List<EventDetails>? get allPublicEvents => throw _privateConstructorUsedError;
  List<EventDetails>? get eventList => throw _privateConstructorUsedError;
  List<EventDetails> get userEvents => throw _privateConstructorUsedError;
  bool get refresh => throw _privateConstructorUsedError;
  EventStatus get status => throw _privateConstructorUsedError;

  /// Create a copy of EventsPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventsPageStateCopyWith<EventsPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventsPageStateCopyWith<$Res> {
  factory $EventsPageStateCopyWith(
          EventsPageState value, $Res Function(EventsPageState) then) =
      _$EventsPageStateCopyWithImpl<$Res, EventsPageState>;
  @useResult
  $Res call(
      {int userBalance,
      List<LocationData>? locationData,
      List<EventDetails>? allPublicEvents,
      List<EventDetails>? eventList,
      List<EventDetails> userEvents,
      bool refresh,
      EventStatus status});
}

/// @nodoc
class _$EventsPageStateCopyWithImpl<$Res, $Val extends EventsPageState>
    implements $EventsPageStateCopyWith<$Res> {
  _$EventsPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventsPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userBalance = null,
    Object? locationData = freezed,
    Object? allPublicEvents = freezed,
    Object? eventList = freezed,
    Object? userEvents = null,
    Object? refresh = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      userBalance: null == userBalance
          ? _value.userBalance
          : userBalance // ignore: cast_nullable_to_non_nullable
              as int,
      locationData: freezed == locationData
          ? _value.locationData
          : locationData // ignore: cast_nullable_to_non_nullable
              as List<LocationData>?,
      allPublicEvents: freezed == allPublicEvents
          ? _value.allPublicEvents
          : allPublicEvents // ignore: cast_nullable_to_non_nullable
              as List<EventDetails>?,
      eventList: freezed == eventList
          ? _value.eventList
          : eventList // ignore: cast_nullable_to_non_nullable
              as List<EventDetails>?,
      userEvents: null == userEvents
          ? _value.userEvents
          : userEvents // ignore: cast_nullable_to_non_nullable
              as List<EventDetails>,
      refresh: null == refresh
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventsPageStateImplCopyWith<$Res>
    implements $EventsPageStateCopyWith<$Res> {
  factory _$$EventsPageStateImplCopyWith(_$EventsPageStateImpl value,
          $Res Function(_$EventsPageStateImpl) then) =
      __$$EventsPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int userBalance,
      List<LocationData>? locationData,
      List<EventDetails>? allPublicEvents,
      List<EventDetails>? eventList,
      List<EventDetails> userEvents,
      bool refresh,
      EventStatus status});
}

/// @nodoc
class __$$EventsPageStateImplCopyWithImpl<$Res>
    extends _$EventsPageStateCopyWithImpl<$Res, _$EventsPageStateImpl>
    implements _$$EventsPageStateImplCopyWith<$Res> {
  __$$EventsPageStateImplCopyWithImpl(
      _$EventsPageStateImpl _value, $Res Function(_$EventsPageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventsPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userBalance = null,
    Object? locationData = freezed,
    Object? allPublicEvents = freezed,
    Object? eventList = freezed,
    Object? userEvents = null,
    Object? refresh = null,
    Object? status = null,
  }) {
    return _then(_$EventsPageStateImpl(
      userBalance: null == userBalance
          ? _value.userBalance
          : userBalance // ignore: cast_nullable_to_non_nullable
              as int,
      locationData: freezed == locationData
          ? _value._locationData
          : locationData // ignore: cast_nullable_to_non_nullable
              as List<LocationData>?,
      allPublicEvents: freezed == allPublicEvents
          ? _value._allPublicEvents
          : allPublicEvents // ignore: cast_nullable_to_non_nullable
              as List<EventDetails>?,
      eventList: freezed == eventList
          ? _value._eventList
          : eventList // ignore: cast_nullable_to_non_nullable
              as List<EventDetails>?,
      userEvents: null == userEvents
          ? _value._userEvents
          : userEvents // ignore: cast_nullable_to_non_nullable
              as List<EventDetails>,
      refresh: null == refresh
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus,
    ));
  }
}

/// @nodoc

class _$EventsPageStateImpl implements _EventsPageState {
  const _$EventsPageStateImpl(
      {this.userBalance = 0,
      final List<LocationData>? locationData = null,
      final List<EventDetails>? allPublicEvents = null,
      final List<EventDetails>? eventList = null,
      final List<EventDetails> userEvents = const [],
      this.refresh = false,
      this.status = EventStatus.initial})
      : _locationData = locationData,
        _allPublicEvents = allPublicEvents,
        _eventList = eventList,
        _userEvents = userEvents;

  @override
  @JsonKey()
  final int userBalance;
  final List<LocationData>? _locationData;
  @override
  @JsonKey()
  List<LocationData>? get locationData {
    final value = _locationData;
    if (value == null) return null;
    if (_locationData is EqualUnmodifiableListView) return _locationData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<EventDetails>? _allPublicEvents;
  @override
  @JsonKey()
  List<EventDetails>? get allPublicEvents {
    final value = _allPublicEvents;
    if (value == null) return null;
    if (_allPublicEvents is EqualUnmodifiableListView) return _allPublicEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

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

  final List<EventDetails> _userEvents;
  @override
  @JsonKey()
  List<EventDetails> get userEvents {
    if (_userEvents is EqualUnmodifiableListView) return _userEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userEvents);
  }

  @override
  @JsonKey()
  final bool refresh;
  @override
  @JsonKey()
  final EventStatus status;

  @override
  String toString() {
    return 'EventsPageState(userBalance: $userBalance, locationData: $locationData, allPublicEvents: $allPublicEvents, eventList: $eventList, userEvents: $userEvents, refresh: $refresh, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventsPageStateImpl &&
            (identical(other.userBalance, userBalance) ||
                other.userBalance == userBalance) &&
            const DeepCollectionEquality()
                .equals(other._locationData, _locationData) &&
            const DeepCollectionEquality()
                .equals(other._allPublicEvents, _allPublicEvents) &&
            const DeepCollectionEquality()
                .equals(other._eventList, _eventList) &&
            const DeepCollectionEquality()
                .equals(other._userEvents, _userEvents) &&
            (identical(other.refresh, refresh) || other.refresh == refresh) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      userBalance,
      const DeepCollectionEquality().hash(_locationData),
      const DeepCollectionEquality().hash(_allPublicEvents),
      const DeepCollectionEquality().hash(_eventList),
      const DeepCollectionEquality().hash(_userEvents),
      refresh,
      status);

  /// Create a copy of EventsPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventsPageStateImplCopyWith<_$EventsPageStateImpl> get copyWith =>
      __$$EventsPageStateImplCopyWithImpl<_$EventsPageStateImpl>(
          this, _$identity);
}

abstract class _EventsPageState implements EventsPageState {
  const factory _EventsPageState(
      {final int userBalance,
      final List<LocationData>? locationData,
      final List<EventDetails>? allPublicEvents,
      final List<EventDetails>? eventList,
      final List<EventDetails> userEvents,
      final bool refresh,
      final EventStatus status}) = _$EventsPageStateImpl;

  @override
  int get userBalance;
  @override
  List<LocationData>? get locationData;
  @override
  List<EventDetails>? get allPublicEvents;
  @override
  List<EventDetails>? get eventList;
  @override
  List<EventDetails> get userEvents;
  @override
  bool get refresh;
  @override
  EventStatus get status;

  /// Create a copy of EventsPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventsPageStateImplCopyWith<_$EventsPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
