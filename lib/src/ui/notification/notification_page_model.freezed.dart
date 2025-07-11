// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NotificationPageState {
  List<NotificationData> get notificationData =>
      throw _privateConstructorUsedError;
  String get readNotificationList => throw _privateConstructorUsedError;

  /// Create a copy of NotificationPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationPageStateCopyWith<NotificationPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationPageStateCopyWith<$Res> {
  factory $NotificationPageStateCopyWith(NotificationPageState value,
          $Res Function(NotificationPageState) then) =
      _$NotificationPageStateCopyWithImpl<$Res, NotificationPageState>;
  @useResult
  $Res call(
      {List<NotificationData> notificationData, String readNotificationList});
}

/// @nodoc
class _$NotificationPageStateCopyWithImpl<$Res,
        $Val extends NotificationPageState>
    implements $NotificationPageStateCopyWith<$Res> {
  _$NotificationPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationData = null,
    Object? readNotificationList = null,
  }) {
    return _then(_value.copyWith(
      notificationData: null == notificationData
          ? _value.notificationData
          : notificationData // ignore: cast_nullable_to_non_nullable
              as List<NotificationData>,
      readNotificationList: null == readNotificationList
          ? _value.readNotificationList
          : readNotificationList // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationPageStateImplCopyWith<$Res>
    implements $NotificationPageStateCopyWith<$Res> {
  factory _$$NotificationPageStateImplCopyWith(
          _$NotificationPageStateImpl value,
          $Res Function(_$NotificationPageStateImpl) then) =
      __$$NotificationPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<NotificationData> notificationData, String readNotificationList});
}

/// @nodoc
class __$$NotificationPageStateImplCopyWithImpl<$Res>
    extends _$NotificationPageStateCopyWithImpl<$Res,
        _$NotificationPageStateImpl>
    implements _$$NotificationPageStateImplCopyWith<$Res> {
  __$$NotificationPageStateImplCopyWithImpl(_$NotificationPageStateImpl _value,
      $Res Function(_$NotificationPageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationData = null,
    Object? readNotificationList = null,
  }) {
    return _then(_$NotificationPageStateImpl(
      notificationData: null == notificationData
          ? _value._notificationData
          : notificationData // ignore: cast_nullable_to_non_nullable
              as List<NotificationData>,
      readNotificationList: null == readNotificationList
          ? _value.readNotificationList
          : readNotificationList // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NotificationPageStateImpl implements _NotificationPageState {
  const _$NotificationPageStateImpl(
      {final List<NotificationData> notificationData = const [],
      this.readNotificationList = ''})
      : _notificationData = notificationData;

  final List<NotificationData> _notificationData;
  @override
  @JsonKey()
  List<NotificationData> get notificationData {
    if (_notificationData is EqualUnmodifiableListView)
      return _notificationData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notificationData);
  }

  @override
  @JsonKey()
  final String readNotificationList;

  @override
  String toString() {
    return 'NotificationPageState(notificationData: $notificationData, readNotificationList: $readNotificationList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationPageStateImpl &&
            const DeepCollectionEquality()
                .equals(other._notificationData, _notificationData) &&
            (identical(other.readNotificationList, readNotificationList) ||
                other.readNotificationList == readNotificationList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_notificationData),
      readNotificationList);

  /// Create a copy of NotificationPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationPageStateImplCopyWith<_$NotificationPageStateImpl>
      get copyWith => __$$NotificationPageStateImplCopyWithImpl<
          _$NotificationPageStateImpl>(this, _$identity);
}

abstract class _NotificationPageState implements NotificationPageState {
  const factory _NotificationPageState(
      {final List<NotificationData> notificationData,
      final String readNotificationList}) = _$NotificationPageStateImpl;

  @override
  List<NotificationData> get notificationData;
  @override
  String get readNotificationList;

  /// Create a copy of NotificationPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationPageStateImplCopyWith<_$NotificationPageStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
