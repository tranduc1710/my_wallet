class AppResponse<O> {
  final int? statusCode;
  String? errorCode;
  String? message;
  final O? data;

  /// statusCode
  /// 450: timeout
  /// 451: cancel upload multipart
  /// 452: loi khac
  AppResponse({
    this.statusCode,
    this.errorCode,
    this.message,
    this.data,
  });
}
