import 'package:base_flutter/domain/entities/session_entity.dart';
import 'package:base_flutter/domain/entities/user_entity.dart';

abstract class LoginRepo {
  Future<SessionEntity> getSession({required String username, required String password});

  Future<UserEntity> getUserInfo();
}
