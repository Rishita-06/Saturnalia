// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_form_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateFormPageState {
  CreateFormPageStatus get status => throw _privateConstructorUsedError;
  List<DyamicFormData> get formList => throw _privateConstructorUsedError;
  int get counter => throw _privateConstructorUsedError;

  /// Create a copy of CreateFormPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateFormPageStateCopyWith<CreateFormPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateFormPageStateCopyWith<$Res> {
  factory $CreateFormPageStateCopyWith(
          CreateFormPageState value, $Res Function(CreateFormPageState) then) =
      _$CreateFormPageStateCopyWithImpl<$Res, CreateFormPageState>;
  @useResult
  $Res call(
      {CreateFormPageStatus status,
      List<DyamicFormData> formList,
      int counter});
}

/// @nodoc
class _$CreateFormPageStateCopyWithImpl<$Res, $Val extends CreateFormPageState>
    implements $CreateFormPageStateCopyWith<$Res> {
  _$CreateFormPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateFormPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? formList = null,
    Object? counter = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CreateFormPageStatus,
      formList: null == formList
          ? _value.formList
          : formList // ignore: cast_nullable_to_non_nullable
              as List<DyamicFormData>,
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateFormPageStateImplCopyWith<$Res>
    implements $CreateFormPageStateCopyWith<$Res> {
  factory _$$CreateFormPageStateImplCopyWith(_$CreateFormPageStateImpl value,
          $Res Function(_$CreateFormPageStateImpl) then) =
      __$$CreateFormPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CreateFormPageStatus status,
      List<DyamicFormData> formList,
      int counter});
}

/// @nodoc
class __$$CreateFormPageStateImplCopyWithImpl<$Res>
    extends _$CreateFormPageStateCopyWithImpl<$Res, _$CreateFormPageStateImpl>
    implements _$$CreateFormPageStateImplCopyWith<$Res> {
  __$$CreateFormPageStateImplCopyWithImpl(_$CreateFormPageStateImpl _value,
      $Res Function(_$CreateFormPageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateFormPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? formList = null,
    Object? counter = null,
  }) {
    return _then(_$CreateFormPageStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CreateFormPageStatus,
      formList: null == formList
          ? _value._formList
          : formList // ignore: cast_nullable_to_non_nullable
              as List<DyamicFormData>,
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CreateFormPageStateImpl implements _CreateFormPageState {
  const _$CreateFormPageStateImpl(
      {this.status = CreateFormPageStatus.initial,
      final List<DyamicFormData> formList = const [
        DyamicFormData(data: FormType(title: ''), id: 0, type: 0)
      ],
      this.counter = 0})
      : _formList = formList;

  @override
  @JsonKey()
  final CreateFormPageStatus status;
  final List<DyamicFormData> _formList;
  @override
  @JsonKey()
  List<DyamicFormData> get formList {
    if (_formList is EqualUnmodifiableListView) return _formList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_formList);
  }

  @override
  @JsonKey()
  final int counter;

  @override
  String toString() {
    return 'CreateFormPageState(status: $status, formList: $formList, counter: $counter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateFormPageStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._formList, _formList) &&
            (identical(other.counter, counter) || other.counter == counter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_formList), counter);

  /// Create a copy of CreateFormPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateFormPageStateImplCopyWith<_$CreateFormPageStateImpl> get copyWith =>
      __$$CreateFormPageStateImplCopyWithImpl<_$CreateFormPageStateImpl>(
          this, _$identity);
}

abstract class _CreateFormPageState implements CreateFormPageState {
  const factory _CreateFormPageState(
      {final CreateFormPageStatus status,
      final List<DyamicFormData> formList,
      final int counter}) = _$CreateFormPageStateImpl;

  @override
  CreateFormPageStatus get status;
  @override
  List<DyamicFormData> get formList;
  @override
  int get counter;

  /// Create a copy of CreateFormPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateFormPageStateImplCopyWith<_$CreateFormPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
