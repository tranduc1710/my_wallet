import 'package:base_flutter/data/data_sources/login_data.dart';
import 'package:base_flutter/data/models/session_model.dart';

class LoginRepo implements LoginDataSource{
  final LoginDataSource dataSource;

  LoginRepo(this.dataSource);

  @override
  Future<SessionModel> getSession({required String username, required String password}) async {
    final res = await
  }
}
