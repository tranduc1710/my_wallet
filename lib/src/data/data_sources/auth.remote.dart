import '../../../core/base/base.dart';

class AuthDataRemote {
  final AppRequest _request = AppRequest();

  // Future<SessionEntity> getSession({required String username, required String password}) async {
  //   final res = await _request.post(
  //     'auth/realms/test/protocol/openid-connect/token',
  //     body: {
  //       "client_id": "login-app",
  //       "username": username,
  //       "password": password,
  //       "grant_type": "password",
  //     },
  //   );
  //
  //   return compute((message) => SessionEntity.fromJson(message), res.data);
  // }
  //
  // Future<UserEntity> getUserInfo() async {
  //   final res = await _request.post(
  //     'dms-service/users/current',
  //     body: {
  //       "currLat": 3.toString(),
  //       "currLng": 1.toString(),
  //     },
  //   );
  //   return compute((message) => UserEntity.fromJson(message), res.data);
  // }
}
