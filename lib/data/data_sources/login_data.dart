import 'package:base_flutter/data/models/session_model.dart';

abstract class LoginDataSource {
  Future<SessionModel> getSession({required String username, required String password});
}

class _LoginDataSource implements LoginDataSource {
  @override
  Future<SessionModel> getSession({required String username, required String password}) {
    // TODO: implement getSession
    throw UnimplementedError();
  }
}
