// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SessionEntity _$SessionEntityFromJson(Map<String, dynamic> json) {
  return _SessionEntity.fromJson(json);
}

/// @nodoc
mixin _$SessionEntity {
  @JsonKey(name: 'access_token')
  String get accessToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'access_token')
  set accessToken(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_in')
  int get expiresIn => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_in')
  set expiresIn(int value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'refresh_expires_in')
  int get refreshExpiresIn => throw _privateConstructorUsedError;
  @JsonKey(name: 'refresh_expires_in')
  set refreshExpiresIn(int value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'refresh_token')
  String get refreshToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'refresh_token')
  set refreshToken(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'token_type')
  String get tokenType => throw _privateConstructorUsedError;
  @JsonKey(name: 'token_type')
  set tokenType(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'not-before-policy')
  int get notBeforePolicy => throw _privateConstructorUsedError;
  @JsonKey(name: 'not-before-policy')
  set notBeforePolicy(int value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'session_state')
  String get sessionState => throw _privateConstructorUsedError;
  @JsonKey(name: 'session_state')
  set sessionState(String value) => throw _privateConstructorUsedError;
  String get scope => throw _privateConstructorUsedError;
  set scope(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionEntityCopyWith<SessionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionEntityCopyWith<$Res> {
  factory $SessionEntityCopyWith(
          SessionEntity value, $Res Function(SessionEntity) then) =
      _$SessionEntityCopyWithImpl<$Res, SessionEntity>;
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token') String accessToken,
      @JsonKey(name: 'expires_in') int expiresIn,
      @JsonKey(name: 'refresh_expires_in') int refreshExpiresIn,
      @JsonKey(name: 'refresh_token') String refreshToken,
      @JsonKey(name: 'token_type') String tokenType,
      @JsonKey(name: 'not-before-policy') int notBeforePolicy,
      @JsonKey(name: 'session_state') String sessionState,
      String scope});
}

/// @nodoc
class _$SessionEntityCopyWithImpl<$Res, $Val extends SessionEntity>
    implements $SessionEntityCopyWith<$Res> {
  _$SessionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? expiresIn = null,
    Object? refreshExpiresIn = null,
    Object? refreshToken = null,
    Object? tokenType = null,
    Object? notBeforePolicy = null,
    Object? sessionState = null,
    Object? scope = null,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int,
      refreshExpiresIn: null == refreshExpiresIn
          ? _value.refreshExpiresIn
          : refreshExpiresIn // ignore: cast_nullable_to_non_nullable
              as int,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      tokenType: null == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
      notBeforePolicy: null == notBeforePolicy
          ? _value.notBeforePolicy
          : notBeforePolicy // ignore: cast_nullable_to_non_nullable
              as int,
      sessionState: null == sessionState
          ? _value.sessionState
          : sessionState // ignore: cast_nullable_to_non_nullable
              as String,
      scope: null == scope
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionEntityImplCopyWith<$Res>
    implements $SessionEntityCopyWith<$Res> {
  factory _$$SessionEntityImplCopyWith(
          _$SessionEntityImpl value, $Res Function(_$SessionEntityImpl) then) =
      __$$SessionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token') String accessToken,
      @JsonKey(name: 'expires_in') int expiresIn,
      @JsonKey(name: 'refresh_expires_in') int refreshExpiresIn,
      @JsonKey(name: 'refresh_token') String refreshToken,
      @JsonKey(name: 'token_type') String tokenType,
      @JsonKey(name: 'not-before-policy') int notBeforePolicy,
      @JsonKey(name: 'session_state') String sessionState,
      String scope});
}

/// @nodoc
class __$$SessionEntityImplCopyWithImpl<$Res>
    extends _$SessionEntityCopyWithImpl<$Res, _$SessionEntityImpl>
    implements _$$SessionEntityImplCopyWith<$Res> {
  __$$SessionEntityImplCopyWithImpl(
      _$SessionEntityImpl _value, $Res Function(_$SessionEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? expiresIn = null,
    Object? refreshExpiresIn = null,
    Object? refreshToken = null,
    Object? tokenType = null,
    Object? notBeforePolicy = null,
    Object? sessionState = null,
    Object? scope = null,
  }) {
    return _then(_$SessionEntityImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int,
      refreshExpiresIn: null == refreshExpiresIn
          ? _value.refreshExpiresIn
          : refreshExpiresIn // ignore: cast_nullable_to_non_nullable
              as int,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      tokenType: null == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
      notBeforePolicy: null == notBeforePolicy
          ? _value.notBeforePolicy
          : notBeforePolicy // ignore: cast_nullable_to_non_nullable
              as int,
      sessionState: null == sessionState
          ? _value.sessionState
          : sessionState // ignore: cast_nullable_to_non_nullable
              as String,
      scope: null == scope
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionEntityImpl implements _SessionEntity {
  _$SessionEntityImpl(
      {@JsonKey(name: 'access_token') required this.accessToken,
      @JsonKey(name: 'expires_in') required this.expiresIn,
      @JsonKey(name: 'refresh_expires_in') required this.refreshExpiresIn,
      @JsonKey(name: 'refresh_token') required this.refreshToken,
      @JsonKey(name: 'token_type') required this.tokenType,
      @JsonKey(name: 'not-before-policy') required this.notBeforePolicy,
      @JsonKey(name: 'session_state') required this.sessionState,
      required this.scope});

  factory _$SessionEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionEntityImplFromJson(json);

  @override
  @JsonKey(name: 'access_token')
  String accessToken;
  @override
  @JsonKey(name: 'expires_in')
  int expiresIn;
  @override
  @JsonKey(name: 'refresh_expires_in')
  int refreshExpiresIn;
  @override
  @JsonKey(name: 'refresh_token')
  String refreshToken;
  @override
  @JsonKey(name: 'token_type')
  String tokenType;
  @override
  @JsonKey(name: 'not-before-policy')
  int notBeforePolicy;
  @override
  @JsonKey(name: 'session_state')
  String sessionState;
  @override
  String scope;

  @override
  String toString() {
    return 'SessionEntity(accessToken: $accessToken, expiresIn: $expiresIn, refreshExpiresIn: $refreshExpiresIn, refreshToken: $refreshToken, tokenType: $tokenType, notBeforePolicy: $notBeforePolicy, sessionState: $sessionState, scope: $scope)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionEntityImplCopyWith<_$SessionEntityImpl> get copyWith =>
      __$$SessionEntityImplCopyWithImpl<_$SessionEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionEntityImplToJson(
      this,
    );
  }
}

abstract class _SessionEntity implements SessionEntity {
  factory _SessionEntity(
      {@JsonKey(name: 'access_token') required String accessToken,
      @JsonKey(name: 'expires_in') required int expiresIn,
      @JsonKey(name: 'refresh_expires_in') required int refreshExpiresIn,
      @JsonKey(name: 'refresh_token') required String refreshToken,
      @JsonKey(name: 'token_type') required String tokenType,
      @JsonKey(name: 'not-before-policy') required int notBeforePolicy,
      @JsonKey(name: 'session_state') required String sessionState,
      required String scope}) = _$SessionEntityImpl;

  factory _SessionEntity.fromJson(Map<String, dynamic> json) =
      _$SessionEntityImpl.fromJson;

  @override
  @JsonKey(name: 'access_token')
  String get accessToken;
  @JsonKey(name: 'access_token')
  set accessToken(String value);
  @override
  @JsonKey(name: 'expires_in')
  int get expiresIn;
  @JsonKey(name: 'expires_in')
  set expiresIn(int value);
  @override
  @JsonKey(name: 'refresh_expires_in')
  int get refreshExpiresIn;
  @JsonKey(name: 'refresh_expires_in')
  set refreshExpiresIn(int value);
  @override
  @JsonKey(name: 'refresh_token')
  String get refreshToken;
  @JsonKey(name: 'refresh_token')
  set refreshToken(String value);
  @override
  @JsonKey(name: 'token_type')
  String get tokenType;
  @JsonKey(name: 'token_type')
  set tokenType(String value);
  @override
  @JsonKey(name: 'not-before-policy')
  int get notBeforePolicy;
  @JsonKey(name: 'not-before-policy')
  set notBeforePolicy(int value);
  @override
  @JsonKey(name: 'session_state')
  String get sessionState;
  @JsonKey(name: 'session_state')
  set sessionState(String value);
  @override
  String get scope;
  set scope(String value);
  @override
  @JsonKey(ignore: true)
  _$$SessionEntityImplCopyWith<_$SessionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
