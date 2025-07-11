// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_scanner_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QrScannerPageState {
  String? get eventId => throw _privateConstructorUsedError;
  String? get eventName => throw _privateConstructorUsedError;
  QrStatus get status => throw _privateConstructorUsedError;
  EventUserData? get data => throw _privateConstructorUsedError;
  String? get errorMesaage => throw _privateConstructorUsedError;

  /// Create a copy of QrScannerPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QrScannerPageStateCopyWith<QrScannerPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrScannerPageStateCopyWith<$Res> {
  factory $QrScannerPageStateCopyWith(
          QrScannerPageState value, $Res Function(QrScannerPageState) then) =
      _$QrScannerPageStateCopyWithImpl<$Res, QrScannerPageState>;
  @useResult
  $Res call(
      {String? eventId,
      String? eventName,
      QrStatus status,
      EventUserData? data,
      String? errorMesaage});
}

/// @nodoc
class _$QrScannerPageStateCopyWithImpl<$Res, $Val extends QrScannerPageState>
    implements $QrScannerPageStateCopyWith<$Res> {
  _$QrScannerPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QrScannerPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = freezed,
    Object? eventName = freezed,
    Object? status = null,
    Object? data = freezed,
    Object? errorMesaage = freezed,
  }) {
    return _then(_value.copyWith(
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      eventName: freezed == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as QrStatus,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as EventUserData?,
      errorMesaage: freezed == errorMesaage
          ? _value.errorMesaage
          : errorMesaage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QrScannerPageStateImplCopyWith<$Res>
    implements $QrScannerPageStateCopyWith<$Res> {
  factory _$$QrScannerPageStateImplCopyWith(_$QrScannerPageStateImpl value,
          $Res Function(_$QrScannerPageStateImpl) then) =
      __$$QrScannerPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? eventId,
      String? eventName,
      QrStatus status,
      EventUserData? data,
      String? errorMesaage});
}

/// @nodoc
class __$$QrScannerPageStateImplCopyWithImpl<$Res>
    extends _$QrScannerPageStateCopyWithImpl<$Res, _$QrScannerPageStateImpl>
    implements _$$QrScannerPageStateImplCopyWith<$Res> {
  __$$QrScannerPageStateImplCopyWithImpl(_$QrScannerPageStateImpl _value,
      $Res Function(_$QrScannerPageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of QrScannerPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = freezed,
    Object? eventName = freezed,
    Object? status = null,
    Object? data = freezed,
    Object? errorMesaage = freezed,
  }) {
    return _then(_$QrScannerPageStateImpl(
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      eventName: freezed == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as QrStatus,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as EventUserData?,
      errorMesaage: freezed == errorMesaage
          ? _value.errorMesaage
          : errorMesaage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$QrScannerPageStateImpl implements _QrScannerPageState {
  const _$QrScannerPageStateImpl(
      {this.eventId = null,
      this.eventName = null,
      this.status = QrStatus.initial,
      this.data = null,
      this.errorMesaage = null});

  @override
  @JsonKey()
  final String? eventId;
  @override
  @JsonKey()
  final String? eventName;
  @override
  @JsonKey()
  final QrStatus status;
  @override
  @JsonKey()
  final EventUserData? data;
  @override
  @JsonKey()
  final String? errorMesaage;

  @override
  String toString() {
    return 'QrScannerPageState(eventId: $eventId, eventName: $eventName, status: $status, data: $data, errorMesaage: $errorMesaage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrScannerPageStateImpl &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.eventName, eventName) ||
                other.eventName == eventName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.errorMesaage, errorMesaage) ||
                other.errorMesaage == errorMesaage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, eventId, eventName, status, data, errorMesaage);

  /// Create a copy of QrScannerPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QrScannerPageStateImplCopyWith<_$QrScannerPageStateImpl> get copyWith =>
      __$$QrScannerPageStateImplCopyWithImpl<_$QrScannerPageStateImpl>(
          this, _$identity);
}

abstract class _QrScannerPageState implements QrScannerPageState {
  const factory _QrScannerPageState(
      {final String? eventId,
      final String? eventName,
      final QrStatus status,
      final EventUserData? data,
      final String? errorMesaage}) = _$QrScannerPageStateImpl;

  @override
  String? get eventId;
  @override
  String? get eventName;
  @override
  QrStatus get status;
  @override
  EventUserData? get data;
  @override
  String? get errorMesaage;

  /// Create a copy of QrScannerPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QrScannerPageStateImplCopyWith<_$QrScannerPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
