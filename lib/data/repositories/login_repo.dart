import '../../domain/entities/session.dart';
import '../../domain/entities/user_info.dart';

abstract class LoginRepo {
  Future<Session> getSession({required String username, required String password});

  Future<UserInfo> getUserInfo();
}
