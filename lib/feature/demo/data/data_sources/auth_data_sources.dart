import 'package:base_flutter/feature/demo/data/repositories/auth_repositories.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/base/base.dart';
import '../../../../core/utils/utils.dart';
import '../models/session_entity.dart';
import '../models/user_entity.dart';

class AuthDataSources implements AuthRepositories {
  AppRequest request = AppRequest();

  @override
  Future<SessionEntity> getSession({required String username, required String password}) async {
    final res = await request.post(
      'auth/realms/test/protocol/openid-connect/token',
      body: {
        "client_id": "login-app",
        "username": username,
        "password": password,
        "grant_type": "password",
        "client_secret": Constant.clientSecret,
      },
    );

    return compute((message) => SessionEntity.fromJson(message), res);
  }

  @override
  Future<UserEntity> getUserInfo() async {
    final res = await request.post(
      'dms-service/users/current',
      body: {
        "currLat": 3.toString(),
        "currLng": 1.toString(),
      },
    );
    return compute((message) => UserEntity.fromJson(message), res);
  }
}
