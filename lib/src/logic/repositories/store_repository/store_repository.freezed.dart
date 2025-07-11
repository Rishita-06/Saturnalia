// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StorePageState {
  List<RewardPointsData>? get rewards => throw _privateConstructorUsedError;
  List<RewardData>? get rewardsList => throw _privateConstructorUsedError;
  List<RewardData>? get publicRewardsList => throw _privateConstructorUsedError;
  int get itemCount => throw _privateConstructorUsedError;
  StorePageStatus get status => throw _privateConstructorUsedError;

  /// Create a copy of StorePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StorePageStateCopyWith<StorePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorePageStateCopyWith<$Res> {
  factory $StorePageStateCopyWith(
          StorePageState value, $Res Function(StorePageState) then) =
      _$StorePageStateCopyWithImpl<$Res, StorePageState>;
  @useResult
  $Res call(
      {List<RewardPointsData>? rewards,
      List<RewardData>? rewardsList,
      List<RewardData>? publicRewardsList,
      int itemCount,
      StorePageStatus status});
}

/// @nodoc
class _$StorePageStateCopyWithImpl<$Res, $Val extends StorePageState>
    implements $StorePageStateCopyWith<$Res> {
  _$StorePageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StorePageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rewards = freezed,
    Object? rewardsList = freezed,
    Object? publicRewardsList = freezed,
    Object? itemCount = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      rewards: freezed == rewards
          ? _value.rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as List<RewardPointsData>?,
      rewardsList: freezed == rewardsList
          ? _value.rewardsList
          : rewardsList // ignore: cast_nullable_to_non_nullable
              as List<RewardData>?,
      publicRewardsList: freezed == publicRewardsList
          ? _value.publicRewardsList
          : publicRewardsList // ignore: cast_nullable_to_non_nullable
              as List<RewardData>?,
      itemCount: null == itemCount
          ? _value.itemCount
          : itemCount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StorePageStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StorePageStateImplCopyWith<$Res>
    implements $StorePageStateCopyWith<$Res> {
  factory _$$StorePageStateImplCopyWith(_$StorePageStateImpl value,
          $Res Function(_$StorePageStateImpl) then) =
      __$$StorePageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<RewardPointsData>? rewards,
      List<RewardData>? rewardsList,
      List<RewardData>? publicRewardsList,
      int itemCount,
      StorePageStatus status});
}

/// @nodoc
class __$$StorePageStateImplCopyWithImpl<$Res>
    extends _$StorePageStateCopyWithImpl<$Res, _$StorePageStateImpl>
    implements _$$StorePageStateImplCopyWith<$Res> {
  __$$StorePageStateImplCopyWithImpl(
      _$StorePageStateImpl _value, $Res Function(_$StorePageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of StorePageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rewards = freezed,
    Object? rewardsList = freezed,
    Object? publicRewardsList = freezed,
    Object? itemCount = null,
    Object? status = null,
  }) {
    return _then(_$StorePageStateImpl(
      rewards: freezed == rewards
          ? _value._rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as List<RewardPointsData>?,
      rewardsList: freezed == rewardsList
          ? _value._rewardsList
          : rewardsList // ignore: cast_nullable_to_non_nullable
              as List<RewardData>?,
      publicRewardsList: freezed == publicRewardsList
          ? _value._publicRewardsList
          : publicRewardsList // ignore: cast_nullable_to_non_nullable
              as List<RewardData>?,
      itemCount: null == itemCount
          ? _value.itemCount
          : itemCount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StorePageStatus,
    ));
  }
}

/// @nodoc

class _$StorePageStateImpl implements _StorePageState {
  const _$StorePageStateImpl(
      {final List<RewardPointsData>? rewards = null,
      final List<RewardData>? rewardsList = null,
      final List<RewardData>? publicRewardsList = null,
      this.itemCount = 0,
      this.status = StorePageStatus.initial})
      : _rewards = rewards,
        _rewardsList = rewardsList,
        _publicRewardsList = publicRewardsList;

  final List<RewardPointsData>? _rewards;
  @override
  @JsonKey()
  List<RewardPointsData>? get rewards {
    final value = _rewards;
    if (value == null) return null;
    if (_rewards is EqualUnmodifiableListView) return _rewards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<RewardData>? _rewardsList;
  @override
  @JsonKey()
  List<RewardData>? get rewardsList {
    final value = _rewardsList;
    if (value == null) return null;
    if (_rewardsList is EqualUnmodifiableListView) return _rewardsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<RewardData>? _publicRewardsList;
  @override
  @JsonKey()
  List<RewardData>? get publicRewardsList {
    final value = _publicRewardsList;
    if (value == null) return null;
    if (_publicRewardsList is EqualUnmodifiableListView)
      return _publicRewardsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final int itemCount;
  @override
  @JsonKey()
  final StorePageStatus status;

  @override
  String toString() {
    return 'StorePageState(rewards: $rewards, rewardsList: $rewardsList, publicRewardsList: $publicRewardsList, itemCount: $itemCount, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorePageStateImpl &&
            const DeepCollectionEquality().equals(other._rewards, _rewards) &&
            const DeepCollectionEquality()
                .equals(other._rewardsList, _rewardsList) &&
            const DeepCollectionEquality()
                .equals(other._publicRewardsList, _publicRewardsList) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_rewards),
      const DeepCollectionEquality().hash(_rewardsList),
      const DeepCollectionEquality().hash(_publicRewardsList),
      itemCount,
      status);

  /// Create a copy of StorePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorePageStateImplCopyWith<_$StorePageStateImpl> get copyWith =>
      __$$StorePageStateImplCopyWithImpl<_$StorePageStateImpl>(
          this, _$identity);
}

abstract class _StorePageState implements StorePageState {
  const factory _StorePageState(
      {final List<RewardPointsData>? rewards,
      final List<RewardData>? rewardsList,
      final List<RewardData>? publicRewardsList,
      final int itemCount,
      final StorePageStatus status}) = _$StorePageStateImpl;

  @override
  List<RewardPointsData>? get rewards;
  @override
  List<RewardData>? get rewardsList;
  @override
  List<RewardData>? get publicRewardsList;
  @override
  int get itemCount;
  @override
  StorePageStatus get status;

  /// Create a copy of StorePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorePageStateImplCopyWith<_$StorePageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
