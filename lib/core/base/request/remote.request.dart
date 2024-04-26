part of '../base.dart';

abstract class RemoteRequest {
  final AppRequest _request = AppRequest();

  Future<AppRequestOutput<T>> POST<T>({
    required String path,
    FutureOr<T> Function(({dynamic data, dynamic object}))? callback,
    String? url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Duration? timeout,
    bool showError = true,
    bool showToast = false,
    CancelToken? cancelToken,
    ContentType contentType = ContentType.json,
  }) async {
    final res = await _request.post(
      path,
      body: body,
      cancelToken: cancelToken,
      contentType: contentType,
      headers: headers,
      timeout: timeout,
      url: url,
    );

    return await _handle(res, callback, showError, showToast);
  }

  Future<AppRequestOutput<T>> GET<T>({
    required String path,
    FutureOr<T> Function(({dynamic data, dynamic object}))? callback,
    String? url,
    Map<String, String>? headers,
    Duration? timeout,
    bool showError = true,
    bool showToast = false,
    CancelToken? cancelToken,
    ContentType contentType = ContentType.json,
  }) async {
    final res = await _request.get(
      path,
      cancelToken: cancelToken,
      contentType: contentType,
      headers: headers,
      timeout: timeout,
      url: url,
    );

    return await _handle(res, callback, showError, showToast);
  }

  Future<AppRequestOutput<T>> MULTIPART<T>({
    required String path,
    FutureOr<T> Function(({dynamic data, dynamic object}))? callback,
    String? url,
    Map<String, String>? headers,
    required Map<String, dynamic>? formData,
    CancelToken? cancelToken,
    bool showToast = false,
    bool showError = true,
    void Function(int)? onSendProgress,
    int timeOut = 60,
  }) async {
    final res = await _request.multipart(
      path,
      cancelToken: cancelToken,
      headers: headers,
      url: url,
      formData: formData,
      onSendProgress: onSendProgress,
      timeOut: timeOut,
    );

    return await _handle(res, callback, showError, showToast);
  }

  String _getMessage(String? errorCode, int? statusCode, String? message, bool showError) {
    // switch (errorCode) {
    //   case null:
    //     if (statusCode.value >= 200 && statusCode.value < 400) {
    //       return AppLanguage.success;
    //     } else if (statusCode.value >= 500) {
    //       return AppLanguage.unableCommunicateServer;
    //     } else {
    //       return AppLanguage.anErrorOccurred;
    //     }
    //   case '':
    //   default:
    //     return message ?? AppLanguage.anErrorOccurred;
    // }
    return '';
  }

  Future<AppRequestOutput<T>> _handle<T>(
    AppResponse response,
    FutureOr<T> Function(({dynamic data, dynamic object}))? callback,
    bool showError,
    bool showToast,
  ) async {
    String msgError = '';
    dynamic data;

    try {
      if (response.data is Map) {
        response.errorCode = response.data['errorCode'];
      }
      response.message = _getMessage(
        response.errorCode,
        response.statusCode,
        response.data is Map ? response.data['errorMessage'] : null,
        showError,
      );

      // if ((response.errorCode != null && response.errorCode != 'S200') || response.data == "") {
      //   msgError = response.message ?? AppLanguage.anErrorOccurred;
      // }
      //
      // if (response.data is Map &&
      //     (response.data?['result']?['errorCode'] != null && response.data?['result']?['errorCode'] != "0")) {
      //   msgError = response.data['result']['errorMessage'] ?? AppLanguage.anErrorOccurred;
      // }

      if (callback != null && response.data != null && response.data != "") {
        data = await compute(
          (message) async => await callback.call(message),
          (
            data: response.data,
            object: response.data["result"]?["object"],
          ),
        );
      }

      // if (showError && Constant.navigatorKey.currentContext != null && msgError.isNotEmpty) {
      // if (showToast) {
      //   AppToast.show(Constant.navigatorKey.currentContext!, message: msgError);
      // } else {
      //   DialogContent(
      //     content: msgError,
      //     showHeaderTitle: true,
      //     isConfirmDialog: true,
      //   ).show(Constant.navigatorKey.currentContext!);
      // }
      // }

      return AppRequestOutput<T>(data: data, response: response);
    } catch (e, s) {
      kPrint(e);
      kPrint(s);
      response.message = "${response.message} | $e";
      return AppRequestOutput<T>(
        data: null,
        response: response,
      );
    }
  }
}
