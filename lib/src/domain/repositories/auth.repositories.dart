
import '../../data/models/session_entity.dart';
import '../../data/models/user_entity.dart';

abstract class AuthRepositories {
  Future<SessionEntity> getSession({required String username, required String password});

  Future<UserEntity> getUserInfo();
}
