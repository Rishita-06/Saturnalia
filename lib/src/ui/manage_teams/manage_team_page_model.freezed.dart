// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_team_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ManageTeamState {
  ManageTeamStatus get status => throw _privateConstructorUsedError;
  List<TeamData>? get team => throw _privateConstructorUsedError;

  /// Create a copy of ManageTeamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ManageTeamStateCopyWith<ManageTeamState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManageTeamStateCopyWith<$Res> {
  factory $ManageTeamStateCopyWith(
          ManageTeamState value, $Res Function(ManageTeamState) then) =
      _$ManageTeamStateCopyWithImpl<$Res, ManageTeamState>;
  @useResult
  $Res call({ManageTeamStatus status, List<TeamData>? team});
}

/// @nodoc
class _$ManageTeamStateCopyWithImpl<$Res, $Val extends ManageTeamState>
    implements $ManageTeamStateCopyWith<$Res> {
  _$ManageTeamStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ManageTeamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? team = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ManageTeamStatus,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as List<TeamData>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ManageTeamStateImplCopyWith<$Res>
    implements $ManageTeamStateCopyWith<$Res> {
  factory _$$ManageTeamStateImplCopyWith(_$ManageTeamStateImpl value,
          $Res Function(_$ManageTeamStateImpl) then) =
      __$$ManageTeamStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ManageTeamStatus status, List<TeamData>? team});
}

/// @nodoc
class __$$ManageTeamStateImplCopyWithImpl<$Res>
    extends _$ManageTeamStateCopyWithImpl<$Res, _$ManageTeamStateImpl>
    implements _$$ManageTeamStateImplCopyWith<$Res> {
  __$$ManageTeamStateImplCopyWithImpl(
      _$ManageTeamStateImpl _value, $Res Function(_$ManageTeamStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManageTeamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? team = freezed,
  }) {
    return _then(_$ManageTeamStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ManageTeamStatus,
      team: freezed == team
          ? _value._team
          : team // ignore: cast_nullable_to_non_nullable
              as List<TeamData>?,
    ));
  }
}

/// @nodoc

class _$ManageTeamStateImpl implements _ManageTeamState {
  const _$ManageTeamStateImpl(
      {this.status = ManageTeamStatus.initial,
      final List<TeamData>? team = null})
      : _team = team;

  @override
  @JsonKey()
  final ManageTeamStatus status;
  final List<TeamData>? _team;
  @override
  @JsonKey()
  List<TeamData>? get team {
    final value = _team;
    if (value == null) return null;
    if (_team is EqualUnmodifiableListView) return _team;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ManageTeamState(status: $status, team: $team)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ManageTeamStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._team, _team));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_team));

  /// Create a copy of ManageTeamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ManageTeamStateImplCopyWith<_$ManageTeamStateImpl> get copyWith =>
      __$$ManageTeamStateImplCopyWithImpl<_$ManageTeamStateImpl>(
          this, _$identity);
}

abstract class _ManageTeamState implements ManageTeamState {
  const factory _ManageTeamState(
      {final ManageTeamStatus status,
      final List<TeamData>? team}) = _$ManageTeamStateImpl;

  @override
  ManageTeamStatus get status;
  @override
  List<TeamData>? get team;

  /// Create a copy of ManageTeamState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ManageTeamStateImplCopyWith<_$ManageTeamStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
