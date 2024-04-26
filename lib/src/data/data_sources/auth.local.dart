import '../../../core/base/request/app.request.dart';

class AuthDataLocal {
  final AppRequest _request = AppRequest();

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
