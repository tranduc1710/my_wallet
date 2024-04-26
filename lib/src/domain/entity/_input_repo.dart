import 'response.dart';

class AppRequestOutput<T> {
  final T? data;
  final AppResponse<dynamic> response;

  AppRequestOutput({required this.data, required this.response});
}
