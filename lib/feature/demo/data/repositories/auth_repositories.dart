import '../models/session_entity.dart';
import '../models/user_entity.dart';

abstract class AuthRepositories {
  Future<SessionEntity> getSession({required String username, required String password});

  Future<UserEntity> getUserInfo();
}
