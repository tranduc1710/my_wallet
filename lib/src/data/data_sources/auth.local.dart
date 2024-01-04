import 'package:flutter/foundation.dart';

import '../../../../core/base/base.dart';
import '../../../../core/utils/utils.dart';
import '../models/session_entity.dart';
import '../models/user_entity.dart';

class AuthDataLocal {
  final AppRequest _request = AppRequest();

  Future<UserEntity> getUserInfo() async {
    final res = await _request.post(
      'dms-service/users/current',
      body: {
        "currLat": 3.toString(),
        "currLng": 1.toString(),
      },
    );
    return compute((message) => UserEntity.fromJson(message), res);
  }
}
