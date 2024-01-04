import 'package:base_flutter/src/data/data_sources/auth.local.dart';
import 'package:base_flutter/src/data/data_sources/auth.remote.dart';

import '../../domain/repositories/auth.repositories.dart';
import '../models/session_entity.dart';
import '../models/user_entity.dart';

class AuthImpl implements AuthRepositories {
  final AuthDataLocal _dataLocal = AuthDataLocal();
  final AuthDataRemote _dataRemote = AuthDataRemote();

  @override
  Future<SessionEntity> getSession({required String username, required String password}) async {
    return await _dataRemote.getSession(username: username, password: password);
  }

  @override
  Future<UserEntity> getUserInfo() async {
    return await _dataLocal.getUserInfo();
  }
}
