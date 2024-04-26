// class GetSessionUseCase implements UseCase<SessionEntity, Map<String, dynamic>> {
//   final AuthRepositories _authRepositories;
//
//   GetSessionUseCase(this._authRepositories);
//
//   @override
//   Future<SessionEntity> call({Map<String, dynamic>? params}) {
//     return _authRepositories.getSession(
//       username: params!['username'],
//       password: params['password'],
//     );
//   }
// }
