import 'package:base_flutter/base/base.dart';
import 'package:base_flutter/data/models/session_model.dart';
import 'package:base_flutter/data/models/user_info_model.dart';
import 'package:base_flutter/data/repositories/login_repo.dart';
import 'package:flutter/foundation.dart';

import '../../utils/utils.dart';

class LoginDataSource implements LoginRepo {
  AppRequest request = AppRequest();

  @override
  Future<SessionModel> getSession({required String username, required String password}) async {
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

    return compute((message) => SessionModel.fromJson(message), res);
  }

  @override
  Future<UserInfoModel> getUserInfo() async {
    final res = await request.post(
      'dms-service/users/current',
      body: {
        "currLat": 3.toString(),
        "currLng": 1.toString(),
      },
    );
    return compute((message) => UserInfoModel.fromJson(message), res);
  }
}
