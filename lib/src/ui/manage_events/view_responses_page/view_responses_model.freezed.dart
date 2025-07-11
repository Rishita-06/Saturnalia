// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view_responses_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ViewResponsesPageState {
  ViewResponsesPageStatus get status => throw _privateConstructorUsedError;
  String? get eventId => throw _privateConstructorUsedError;
  List<EventUserData>? get data => throw _privateConstructorUsedError;
  FormData? get formData => throw _privateConstructorUsedError;
  bool get hasform => throw _privateConstructorUsedError;
  String get eventName => throw _privateConstructorUsedError;

  /// Create a copy of ViewResponsesPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ViewResponsesPageStateCopyWith<ViewResponsesPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViewResponsesPageStateCopyWith<$Res> {
  factory $ViewResponsesPageStateCopyWith(ViewResponsesPageState value,
          $Res Function(ViewResponsesPageState) then) =
      _$ViewResponsesPageStateCopyWithImpl<$Res, ViewResponsesPageState>;
  @useResult
  $Res call(
      {ViewResponsesPageStatus status,
      String? eventId,
      List<EventUserData>? data,
      FormData? formData,
      bool hasform,
      String eventName});
}

/// @nodoc
class _$ViewResponsesPageStateCopyWithImpl<$Res,
        $Val extends ViewResponsesPageState>
    implements $ViewResponsesPageStateCopyWith<$Res> {
  _$ViewResponsesPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ViewResponsesPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? eventId = freezed,
    Object? data = freezed,
    Object? formData = freezed,
    Object? hasform = null,
    Object? eventName = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ViewResponsesPageStatus,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<EventUserData>?,
      formData: freezed == formData
          ? _value.formData
          : formData // ignore: cast_nullable_to_non_nullable
              as FormData?,
      hasform: null == hasform
          ? _value.hasform
          : hasform // ignore: cast_nullable_to_non_nullable
              as bool,
      eventName: null == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ViewResponsesPageStateImplCopyWith<$Res>
    implements $ViewResponsesPageStateCopyWith<$Res> {
  factory _$$ViewResponsesPageStateImplCopyWith(
          _$ViewResponsesPageStateImpl value,
          $Res Function(_$ViewResponsesPageStateImpl) then) =
      __$$ViewResponsesPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ViewResponsesPageStatus status,
      String? eventId,
      List<EventUserData>? data,
      FormData? formData,
      bool hasform,
      String eventName});
}

/// @nodoc
class __$$ViewResponsesPageStateImplCopyWithImpl<$Res>
    extends _$ViewResponsesPageStateCopyWithImpl<$Res,
        _$ViewResponsesPageStateImpl>
    implements _$$ViewResponsesPageStateImplCopyWith<$Res> {
  __$$ViewResponsesPageStateImplCopyWithImpl(
      _$ViewResponsesPageStateImpl _value,
      $Res Function(_$ViewResponsesPageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ViewResponsesPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? eventId = freezed,
    Object? data = freezed,
    Object? formData = freezed,
    Object? hasform = null,
    Object? eventName = null,
  }) {
    return _then(_$ViewResponsesPageStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ViewResponsesPageStatus,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<EventUserData>?,
      formData: freezed == formData
          ? _value.formData
          : formData // ignore: cast_nullable_to_non_nullable
              as FormData?,
      hasform: null == hasform
          ? _value.hasform
          : hasform // ignore: cast_nullable_to_non_nullable
              as bool,
      eventName: null == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ViewResponsesPageStateImpl implements _ViewResponsesPageState {
  const _$ViewResponsesPageStateImpl(
      {this.status = ViewResponsesPageStatus.initial,
      this.eventId = null,
      final List<EventUserData>? data = null,
      this.formData = null,
      this.hasform = false,
      this.eventName = ''})
      : _data = data;

  @override
  @JsonKey()
  final ViewResponsesPageStatus status;
  @override
  @JsonKey()
  final String? eventId;
  final List<EventUserData>? _data;
  @override
  @JsonKey()
  List<EventUserData>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final FormData? formData;
  @override
  @JsonKey()
  final bool hasform;
  @override
  @JsonKey()
  final String eventName;

  @override
  String toString() {
    return 'ViewResponsesPageState(status: $status, eventId: $eventId, data: $data, formData: $formData, hasform: $hasform, eventName: $eventName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViewResponsesPageStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.formData, formData) ||
                other.formData == formData) &&
            (identical(other.hasform, hasform) || other.hasform == hasform) &&
            (identical(other.eventName, eventName) ||
                other.eventName == eventName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, eventId,
      const DeepCollectionEquality().hash(_data), formData, hasform, eventName);

  /// Create a copy of ViewResponsesPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ViewResponsesPageStateImplCopyWith<_$ViewResponsesPageStateImpl>
      get copyWith => __$$ViewResponsesPageStateImplCopyWithImpl<
          _$ViewResponsesPageStateImpl>(this, _$identity);
}

abstract class _ViewResponsesPageState implements ViewResponsesPageState {
  const factory _ViewResponsesPageState(
      {final ViewResponsesPageStatus status,
      final String? eventId,
      final List<EventUserData>? data,
      final FormData? formData,
      final bool hasform,
      final String eventName}) = _$ViewResponsesPageStateImpl;

  @override
  ViewResponsesPageStatus get status;
  @override
  String? get eventId;
  @override
  List<EventUserData>? get data;
  @override
  FormData? get formData;
  @override
  bool get hasform;
  @override
  String get eventName;

  /// Create a copy of ViewResponsesPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ViewResponsesPageStateImplCopyWith<_$ViewResponsesPageStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
