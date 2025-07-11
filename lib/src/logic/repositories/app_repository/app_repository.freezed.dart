// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppState {
  User? get authUser => throw _privateConstructorUsedError;
  UserData? get userData => throw _privateConstructorUsedError;
  bool get thaparId => throw _privateConstructorUsedError;
  String? get selectedEvent => throw _privateConstructorUsedError;
  AppStatus get status => throw _privateConstructorUsedError;
  List<SponserAppData>? get sponserApp => throw _privateConstructorUsedError;
  DateTime? get lastFcmIDUpdatedAt => throw _privateConstructorUsedError;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call(
      {User? authUser,
      UserData? userData,
      bool thaparId,
      String? selectedEvent,
      AppStatus status,
      List<SponserAppData>? sponserApp,
      DateTime? lastFcmIDUpdatedAt});
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authUser = freezed,
    Object? userData = freezed,
    Object? thaparId = null,
    Object? selectedEvent = freezed,
    Object? status = null,
    Object? sponserApp = freezed,
    Object? lastFcmIDUpdatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      authUser: freezed == authUser
          ? _value.authUser
          : authUser // ignore: cast_nullable_to_non_nullable
              as User?,
      userData: freezed == userData
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as UserData?,
      thaparId: null == thaparId
          ? _value.thaparId
          : thaparId // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedEvent: freezed == selectedEvent
          ? _value.selectedEvent
          : selectedEvent // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AppStatus,
      sponserApp: freezed == sponserApp
          ? _value.sponserApp
          : sponserApp // ignore: cast_nullable_to_non_nullable
              as List<SponserAppData>?,
      lastFcmIDUpdatedAt: freezed == lastFcmIDUpdatedAt
          ? _value.lastFcmIDUpdatedAt
          : lastFcmIDUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppStateImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppStateImplCopyWith(
          _$AppStateImpl value, $Res Function(_$AppStateImpl) then) =
      __$$AppStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {User? authUser,
      UserData? userData,
      bool thaparId,
      String? selectedEvent,
      AppStatus status,
      List<SponserAppData>? sponserApp,
      DateTime? lastFcmIDUpdatedAt});
}

/// @nodoc
class __$$AppStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppStateImpl>
    implements _$$AppStateImplCopyWith<$Res> {
  __$$AppStateImplCopyWithImpl(
      _$AppStateImpl _value, $Res Function(_$AppStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authUser = freezed,
    Object? userData = freezed,
    Object? thaparId = null,
    Object? selectedEvent = freezed,
    Object? status = null,
    Object? sponserApp = freezed,
    Object? lastFcmIDUpdatedAt = freezed,
  }) {
    return _then(_$AppStateImpl(
      authUser: freezed == authUser
          ? _value.authUser
          : authUser // ignore: cast_nullable_to_non_nullable
              as User?,
      userData: freezed == userData
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as UserData?,
      thaparId: null == thaparId
          ? _value.thaparId
          : thaparId // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedEvent: freezed == selectedEvent
          ? _value.selectedEvent
          : selectedEvent // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AppStatus,
      sponserApp: freezed == sponserApp
          ? _value._sponserApp
          : sponserApp // ignore: cast_nullable_to_non_nullable
              as List<SponserAppData>?,
      lastFcmIDUpdatedAt: freezed == lastFcmIDUpdatedAt
          ? _value.lastFcmIDUpdatedAt
          : lastFcmIDUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$AppStateImpl with DiagnosticableTreeMixin implements _AppState {
  const _$AppStateImpl(
      {this.authUser = null,
      this.userData = null,
      this.thaparId = false,
      this.selectedEvent = null,
      this.status = AppStatus.initial,
      final List<SponserAppData>? sponserApp = null,
      this.lastFcmIDUpdatedAt = null})
      : _sponserApp = sponserApp;

  @override
  @JsonKey()
  final User? authUser;
  @override
  @JsonKey()
  final UserData? userData;
  @override
  @JsonKey()
  final bool thaparId;
  @override
  @JsonKey()
  final String? selectedEvent;
  @override
  @JsonKey()
  final AppStatus status;
  final List<SponserAppData>? _sponserApp;
  @override
  @JsonKey()
  List<SponserAppData>? get sponserApp {
    final value = _sponserApp;
    if (value == null) return null;
    if (_sponserApp is EqualUnmodifiableListView) return _sponserApp;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final DateTime? lastFcmIDUpdatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppState(authUser: $authUser, userData: $userData, thaparId: $thaparId, selectedEvent: $selectedEvent, status: $status, sponserApp: $sponserApp, lastFcmIDUpdatedAt: $lastFcmIDUpdatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppState'))
      ..add(DiagnosticsProperty('authUser', authUser))
      ..add(DiagnosticsProperty('userData', userData))
      ..add(DiagnosticsProperty('thaparId', thaparId))
      ..add(DiagnosticsProperty('selectedEvent', selectedEvent))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('sponserApp', sponserApp))
      ..add(DiagnosticsProperty('lastFcmIDUpdatedAt', lastFcmIDUpdatedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateImpl &&
            (identical(other.authUser, authUser) ||
                other.authUser == authUser) &&
            (identical(other.userData, userData) ||
                other.userData == userData) &&
            (identical(other.thaparId, thaparId) ||
                other.thaparId == thaparId) &&
            (identical(other.selectedEvent, selectedEvent) ||
                other.selectedEvent == selectedEvent) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._sponserApp, _sponserApp) &&
            (identical(other.lastFcmIDUpdatedAt, lastFcmIDUpdatedAt) ||
                other.lastFcmIDUpdatedAt == lastFcmIDUpdatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      authUser,
      userData,
      thaparId,
      selectedEvent,
      status,
      const DeepCollectionEquality().hash(_sponserApp),
      lastFcmIDUpdatedAt);

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      __$$AppStateImplCopyWithImpl<_$AppStateImpl>(this, _$identity);
}

abstract class _AppState implements AppState {
  const factory _AppState(
      {final User? authUser,
      final UserData? userData,
      final bool thaparId,
      final String? selectedEvent,
      final AppStatus status,
      final List<SponserAppData>? sponserApp,
      final DateTime? lastFcmIDUpdatedAt}) = _$AppStateImpl;

  @override
  User? get authUser;
  @override
  UserData? get userData;
  @override
  bool get thaparId;
  @override
  String? get selectedEvent;
  @override
  AppStatus get status;
  @override
  List<SponserAppData>? get sponserApp;
  @override
  DateTime? get lastFcmIDUpdatedAt;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
