import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@unfreezed
class UserEntity with _$UserEntity {
  factory UserEntity({
    required String id,
    required String username,
    required bool enabled,
    required String firstName,
    required String lastName,
    required String email,
    required String staffId,
    required String staffCode,
    required String staffName,
    required String shopId,
    required List<dynamic> roles,
    required List<dynamic> functions,
    required bool checkResult,
    required String tenantId,
    required String clientCode,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
}
