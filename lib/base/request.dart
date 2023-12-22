part of 'base.dart';

int _count401 = 0;

class AppRequest<O> {
  final Dio _dio = Dio();
  BehaviorSubject<int>? _progress;

  String eTimeout = AppLanguage.connectionTimedOut;

  void closeRequest(CancelToken cancelToken) {
    kPrint("CANCEL REQUEST");
    if (!cancelToken.isCancelled) cancelToken.cancel();
  }

  Future<O?> get(
    String path, {
    String? url,
    Map<String, String>? headers,
    Duration? timeout,
    bool showError = true,
    bool hasToken = true,
    bool hasLogout = true,
    CancelToken? cancelToken,
    ContentType contentType = ContentType.formUrlEncoded,
  }) async =>
      await _request(
        type: RequestType.get,
        url: (url ?? Constant.pathApi) + path,
        showError: showError,
        hasToken: hasToken,
        headers: headers,
        cancelToken: cancelToken,
        contentType: contentType,
        hasLogout: hasLogout,
        timeout: timeout,
      );

  Future<O?> post(
    String path, {
    String? url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Duration? timeout,
    bool showError = true,
    bool hasToken = true,
    bool hasLogout = true,
    CancelToken? cancelToken,
    ContentType contentType = ContentType.formUrlEncoded,
  }) async =>
      await _request(
        type: RequestType.post,
        url: (url ?? Constant.pathApi) + path,
        showError: showError,
        hasToken: hasToken,
        hasLogout: hasLogout,
        headers: headers,
        body: body,
        cancelToken: cancelToken,
        contentType: contentType,
        timeout: timeout,
      );

  Future<O?> delete(
    String path, {
    String? url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Duration? timeout,
    bool showError = true,
    bool hasToken = true,
    bool hasLogout = true,
    CancelToken? cancelToken,
    ContentType contentType = ContentType.formUrlEncoded,
  }) async =>
      await _request(
        type: RequestType.delete,
        url: (url ?? Constant.pathApi) + path,
        showError: showError,
        hasToken: hasToken,
        hasLogout: hasLogout,
        headers: headers,
        body: body,
        cancelToken: cancelToken,
        contentType: contentType,
        timeout: timeout,
      );

  Future _request({
    required String url,
    required RequestType type,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Duration? timeout,
    bool showError = true,
    bool hasToken = true,
    bool hasLogout = true,
    CancelToken? cancelToken,
    ContentType contentType = ContentType.formUrlEncoded,
  }) async {
    headers ??= {};
    cancelToken ??= CancelToken();
    var idRequest = DateTime.now().millisecondsSinceEpoch;
    var logRequest = "";

    if (!headers.containsKey('Authorization') &&
        Constant.session?.accessToken != null &&
        hasToken) {
      headers["Authorization"] = "Bearer ${Constant.session?.accessToken}";
    }

    switch (contentType) {
      case ContentType.formUrlEncoded:
        _dio.options.contentType = Headers.formUrlEncodedContentType;
        break;
      case ContentType.json:
        _dio.options.contentType = Headers.jsonContentType;
        break;
    }

    _dio.options
      ..headers = headers
      ..validateStatus = (status) {
        if (status == null) return false;
        return true;
      };

    if (kDebugMode) {
      switch (type) {
        case RequestType.get:
          logRequest = "\n----------REQUEST GET ID $idRequest----------"
              "\ncurl --location --request GET '$url' \\"
              "\n${_dio.options.headers.entries.toList().map((e) => '--header \'${e.key}: ${e.value}\'').join(' \\\n')}"
              "\n------------------------------\n";
          break;
        case RequestType.post:
          logRequest = "\n----------REQUEST POST ID $idRequest----------"
              "\ncurl --location '$url' \\"
              "\n${_dio.options.headers.entries.toList().map((e) => '--header \'${e.key}: ${e.value}\'').join(' \\\n')}"
              "${body != null ? "\n--data '${jsonEncode(body)}'" : ''}"
              "\n------------------------------\n";
          break;
        case RequestType.delete:
          logRequest = "\n----------REQUEST DELETE ID $idRequest----------"
              "\ncurl --location --request DELETE '$url' \\"
              "\n${_dio.options.headers.entries.toList().map((e) => '--header \'${e.key}: ${e.value}\'').join(' \\\n')}"
              "${body != null ? "\n--data '${jsonEncode(body)}'" : ''}"
              "\n------------------------------\n";
          break;
      }
      kPrint(logRequest);
    }

    try {
      Future<dio.Response>? request;

      switch (type) {
        case RequestType.get:
          request = _dio.get(
            url,
            cancelToken: cancelToken,
          );
          break;
        case RequestType.post:
          request = _dio.post(
            url,
            data: body,
            cancelToken: cancelToken,
          );
          break;
        case RequestType.delete:
          request = _dio.delete(
            url,
            data: body,
            cancelToken: cancelToken,
          );
      }

      var isTimeout = false;
      var res = await request.timeout(
        timeout ?? Constant.timeRequest,
        onTimeout: () {
          isTimeout = true;
          _onTimeout(showError);
          kPrint("REQUEST ID $idRequest TIME OUT");
          return dio.Response(requestOptions: RequestOptions(path: ''));
        },
      ).catchError(
        (e, s) {
          return dio.Response(requestOptions: RequestOptions(path: ''));
        },
      );

      if (isTimeout) return;

      if (kDebugMode) {
        kPrint("\n----------RESPONSE ID: $idRequest----------"
            "\nSTATUS CODE: ${res.statusCode}"
            "\nDATA: ${res.data}"
            "\n------------------------------\n");
      }

      if (res.statusCode != null && res.statusCode! >= 200 && res.statusCode! < 400) {
        try {
          if (res.data is O) {
            return res.data;
          } else if (showError) {
            AppDialog().alert(
              title: AppLanguage.error,
              content: AppLanguage.errGettingData,
            );
          }
          return;
        } catch (e, s) {
          kPrint("REQUEST ID $idRequest: $e\n$s");
          if (showError) {
            AppDialog().alert(
              title: AppLanguage.error,
              content: AppLanguage.errGettingData,
            );
          }
          return;
        }
      } else {
        switch (res.statusCode) {
          case 401:
            _onLoginExpires(showError, hasLogout);
            break;
          default:
            if (showError) {
              AppDialog().alert(
                title: AppLanguage.error,
                content: "${res.data ?? AppLanguage.noDataReturned}",
              );
            }
            break;
        }
      }
    } catch (e, s) {
      closeRequest(cancelToken);
      _catchError(e, s, showError, hasLogout);
    }
  }

  Future<void> multipart(
    String url, {
    Map<String, String>? headers,
    @required Map<String, dynamic>? formData,
    TypeShowUpload? typeShowUpload,
    CancelToken? cancelToken,
    void Function(int progress)? onSendProgress,
    void Function(dynamic res)? onSuccess,
    void Function(String onError)? onError,
    void Function()? onCancel,
    int timeOut = 60,
  }) async {
    final form = dio.FormData.fromMap(formData!);
    bool isTimeOut = false;
    bool isCancel = false;
    var idRequest = DateTime.now().millisecondsSinceEpoch;
    cancelToken ??= CancelToken();

    if (headers != null) _dio.options.headers = headers;

    onSuccess ??= (_) => _;
    onError ??= (_) => _;

    kPrint("\n----------REQUEST Multipart----------");
    kPrint("ID $idRequest:");
    kPrint("Url: $url");
    kPrint("Header: ${_dio.options.headers}");
    kPrint("FormData: $formData");
    kPrint("------------------------------\n");

    switch (typeShowUpload) {
      case TypeShowUpload.dialog:
        _progress = 0.rx;

        showDialog(context: context, builder: (context) => _layoutDialog()).then(
          (value) {
            if (_progress!.value < 100) {
              closeRequest(cancelToken!);
              onCancel?.call();
            }
          },
        );
        break;
      default:
        break;
    }

    dio.Response res = await _dio.post(
      url,
      data: form,
      cancelToken: cancelToken,
      onSendProgress: (count, total) {
        int progress = ((count / total) * 100).toInt();
        int lastProgress = progress > 100
            ? 100
            : progress < 0
                ? 0
                : progress;
        _progress!.value = lastProgress;
        if (lastProgress == 100) context.back();
        if (onSendProgress != null) onSendProgress(lastProgress);
      },
    ).timeout(
      Duration(seconds: timeOut),
      onTimeout: () {
        isTimeOut = true;
        kPrint(eTimeout);
        return dio.Response(requestOptions: RequestOptions(path: ''));
      },
    ).catchError((e, s) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        isCancel = true;
      }

      kPrint("$e\n$s");

      closeRequest(cancelToken!);

      onError?.call(e.toString());
    });

    if (isCancel) {
      kPrint("CANCEL REQUEST");
      return;
    }

    kPrint("\n----------RESPONSE ID $idRequest----------"
        "\nDATA: ${res.data}"
        "\n------------------------------\n");

    if (isTimeOut) return onError(eTimeout);

    if (res.statusCode! >= 200 && res.statusCode! < 400) {
      return onSuccess(res.data.toString().isEmpty ? "" : res.data);
    } else {
      return onError(res.data.isEmpty ? AppLanguage.uploadFailed : res.data);
    }
  }

  Widget _layoutDialog() => Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          height: .3.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constant.radius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircularProgressIndicator(),
              SizedBox(height: .02.w),
              Text(
                "${_progress!.value}%",
                style: AppStyle.normal,
              ),
            ],
          ),
        ),
      );

  Future<void> _catchError(
    var e,
    StackTrace s,
    bool showError,
    bool hasLogout,
  ) async {
    kPrint("$e\n$s");

    if (e.runtimeType is SocketException) {
      if (showError) AppDialog().alert(title: AppLanguage.error, content: AppLanguage.networkError);
      return;
    }
    if (e is dio.DioException && e.response?.statusCode != null && e.response?.statusCode == 401) {
      _onLoginExpires(showError, hasLogout);
      return;
    }
    if (showError) AppDialog().alert(title: AppLanguage.error, content: AppLanguage.errorOccurred);
  }

  void _onTimeout(
    bool showError,
  ) {
    if (showError) AppDialog().alert(title: AppLanguage.error, content: eTimeout);
  }

  void _onLoginExpires(bool showError, bool hasLogout) async {
    if (_count401 != 0) return;
    _count401 += _count401;
    if (hasLogout) {
      // await BPrefs.init();
      // BPrefs.clear();
      // BSwitchScreen.pushNameAndRemove('/');
    }
    if (showError) {
      AppDialog().alert(title: AppLanguage.alert, content: AppLanguage.loginExpired);
    } else {
      // BToast.show(AppLanguage.loginExpired);
    }
    _count401 -= _count401;
  }
}

enum TypeShowUpload {
  none,
  dialog,
}

enum RequestType {
  get,
  post,
  delete,
}

enum ContentType {
  formUrlEncoded,
  json,
}
