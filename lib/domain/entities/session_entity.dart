import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_entity.freezed.dart';
part 'session_entity.g.dart';

@unfreezed
class SessionEntity with _$SessionEntity {
  factory SessionEntity({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'expires_in') required int expiresIn,
    @JsonKey(name: 'refresh_expires_in') required int refreshExpiresIn,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'token_type') required String tokenType,
    @JsonKey(name: 'not-before-policy') required int notBeforePolicy,
    @JsonKey(name: 'session_state') required String sessionState,
    required String scope,
  }) = _SessionEntity;

  factory SessionEntity.fromJson(Map<String, dynamic> json) => _$SessionEntityFromJson(json);
}
