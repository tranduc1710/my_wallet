import 'package:base_flutter/feature/demo/data/repositories/auth_repositories.dart';

import '../../data/data_sources/auth_data_sources.dart';
import '../../data/models/session_entity.dart';
import '../../data/models/user_entity.dart';

class LoginUseCase {
  final AuthRepositories _authRepositories = AuthDataSources();

  Future<SessionEntity> getSession({required String username, required String password}) async {
    return await _authRepositories.getSession(username: username, password: password);
  }

  Future<UserEntity> getUserInfo() async {
    return await _authRepositories.getUserInfo();
  }
}
