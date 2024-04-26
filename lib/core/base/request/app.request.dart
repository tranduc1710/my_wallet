part of '../base.dart';

class AppRequest {
  void closeRequest(CancelToken cancelToken) {
    kPrint("CANCEL REQUEST");
    if (!cancelToken.isCancelled) cancelToken.cancel();
  }

  Future<AppResponse> get(
    String path, {
    String? url,
    Map<String, String>? headers,
    Duration? timeout,
    CancelToken? cancelToken,
    ContentType contentType = ContentType.json,
  }) async {
    return await _request(
      type: _RequestType.get,
      url: (url ?? Constant.pathApi) + path,
      headers: headers,
      cancelToken: cancelToken,
      contentType: contentType,
      timeout: timeout,
    );
  }

  Future<AppResponse> post(
    String path, {
    String? url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Duration? timeout,
    CancelToken? cancelToken,
    ContentType contentType = ContentType.json,
  }) async {
    return await _request(
      type: _RequestType.post,
      url: (url ?? Constant.pathApi) + path,
      headers: headers,
      body: body,
      cancelToken: cancelToken,
      contentType: contentType,
      timeout: timeout,
    );
  }

  Future<AppResponse> put(
    String path, {
    String? url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Duration? timeout,
    CancelToken? cancelToken,
    ContentType contentType = ContentType.json,
  }) async {
    return await _request(
      type: _RequestType.put,
      url: (url ?? Constant.pathApi) + path,
      headers: headers,
      body: body,
      cancelToken: cancelToken,
      contentType: contentType,
      timeout: timeout,
    );
  }

  Future<AppResponse> delete(
    String path, {
    String? url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Duration? timeout,
    CancelToken? cancelToken,
    ContentType contentType = ContentType.json,
  }) async {
    return await _request(
      type: _RequestType.delete,
      url: (url ?? Constant.pathApi) + path,
      headers: headers,
      body: body,
      cancelToken: cancelToken,
      contentType: contentType,
      timeout: timeout,
    );
  }

  Future<AppResponse> _request({
    required String url,
    required _RequestType type,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Duration? timeout,
    CancelToken? cancelToken,
    ContentType contentType = ContentType.formUrlEncoded,
  }) async {
    Dio dio = Dio();
    headers ??= {};
    cancelToken ??= CancelToken();
    var idRequest = DateTime.now().millisecondsSinceEpoch;
    var logRequest = "";

    switch (contentType) {
      case ContentType.formUrlEncoded:
        dio.options.contentType = Headers.formUrlEncodedContentType;
        break;
      case ContentType.json:
        dio.options.contentType = Headers.jsonContentType;
        break;
    }

    // headers["Authorization"] = 'Bearer ${Constant.userInfo?.token}';

    dio.options
      ..headers = headers
      ..validateStatus = (status) {
        if (status == null) return false;
        return true;
      };

    if (kDebugMode) {
      switch (type) {
        case _RequestType.get:
          logRequest = "\ncurl --location --request GET '$url' \\"
              "\n${dio.options.headers.entries.toList().map((e) => '--header \'${e.key}: ${e.value}\'').join(' \\\n')}";
          break;
        case _RequestType.post:
          logRequest = "\ncurl --location --request POST '$url' \\"
              "\n${dio.options.headers.entries.toList().map((e) => '--header \'${e.key}: ${e.value}\'').join(' \\\n')}"
              "${body != null ? "\n${contentType == ContentType.formUrlEncoded ? body.entries.map((e) => "--data-urlencode '${e.key}=${e.value}'").join(' \\\n') : "--data '${jsonEncode(body)}'"}" : ""}";
          break;
        case _RequestType.put:
          logRequest = "\ncurl --location --request PUT '$url' \\"
              "\n${dio.options.headers.entries.toList().map((e) => '--header \'${e.key}: ${e.value}\'').join(' \\\n')}"
              "${body != null ? "\n${contentType == ContentType.formUrlEncoded ? body.entries.map((e) => "--data-urlencode '${e.key}=${e.value}'").join(' \\\n') : "--data '${jsonEncode(body)}'"}" : ""}";
          break;
        case _RequestType.delete:
          logRequest = "\ncurl --location --request DELETE '$url' \\"
              "\n${dio.options.headers.entries.toList().map((e) => '--header \'${e.key}: ${e.value}\'').join(' \\\n')}"
              "${body != null ? "\n--data '${jsonEncode(body)}'" : ''}";
          break;
      }
      kPrint('$logRequest\n--------✈----\n☃ Đã gửi request...\n', 'REQUEST ${_RequestType.get.name.toUpperCase()} ID $idRequest');
    }

    try {
      Future<Response>? request;

      switch (type) {
        case _RequestType.get:
          request = dio.get(
            url,
            cancelToken: cancelToken,
          );
          break;
        case _RequestType.post:
          request = dio.post(
            url,
            data: body,
            cancelToken: cancelToken,
          );
          break;
        case _RequestType.put:
          request = dio.put(
            url,
            data: body,
            cancelToken: cancelToken,
          );
          break;
        case _RequestType.delete:
          request = dio.delete(
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
          kPrint("REQUEST ID $idRequest TIME OUT");
          return Response(requestOptions: RequestOptions(path: ''));
        },
      ).catchError((e, s) => Response(requestOptions: RequestOptions(path: '')));

      if (isTimeout) return AppResponse(statusCode: 450);

      if (kDebugMode) {
        kPrint(
            "\n↪ Có kết quả rồi"
                "\n✯✯✯✯✯"
                "\nSTATUS CODE: ${res.statusCode}"
                "\nDATA: ${res.data}"
                "\n--------✄----"
                "\n© Hết rồi nhé\n",
            'RESPONSE ID $idRequest');
      }

      return AppResponse(
        statusCode: res.statusCode,
        message: res.statusMessage,
        data: res.data,
      );
    } catch (e, s) {
      closeRequest(cancelToken);
      kPrint("$e\n$s");
      return AppResponse(
        statusCode: 452,
        data: null,
      );
    }
  }

  Future<AppResponse> multipart(
    String path, {
    String? url,
    Map<String, String>? headers,
    required Map<String, dynamic>? formData,
    CancelToken? cancelToken,
    void Function(int progress)? onSendProgress,
    int timeOut = 60,
  }) async {
    final dio = Dio();
    final form = FormData.fromMap(formData!);
    bool isTimeOut = false;
    bool isCancel = false;
    var idRequest = DateTime.now().millisecondsSinceEpoch;
    cancelToken ??= CancelToken();
    headers ??= {};

    // dio.httpClientAdapter = IOHttpClientAdapter(
    //   createHttpClient: () {
    //     final context = SecurityContext();
    //     context.setTrustedCertificatesBytes(Certificates.getCert().buffer.asUint8List());
    //     return HttpClient(context: context);
    //   },
    // );

    dio.options
      ..headers = headers
      ..validateStatus = (status) {
        if (status == null) return false;
        return true;
      };

    kPrint(
        "\n----------REQUEST Multipart ID $idRequest----------"
            "\ncurl --location '${(url ?? Constant.pathApi) + path}' \\"
            "\n${dio.options.headers.entries.toList().map((e) => '--header \'${e.key}: ${e.value}\'').join(' \\\n')}"
            "\n${formData.entries.map((e) => "--form '${e.key}=@\"${e.value is MultipartFile ? (e.value as MultipartFile).filename : e.value}\"'").join("\n")}"
            "\n------------------------------\n",
        'LOG-REQUEST');

    Response res = await dio.post(
      (url ?? Constant.pathApi) + path,
      data: form,
      cancelToken: cancelToken,
      onSendProgress: (count, total) {
        int value = ((count / total) * 100).toInt();
        int lastProgress = value > 100
            ? 100
            : value < 0
                ? 0
                : value;
        if (onSendProgress != null) onSendProgress(lastProgress);
      },
    ).timeout(
      Duration(seconds: timeOut),
      onTimeout: () {
        isTimeOut = true;
        return Response(requestOptions: RequestOptions());
      },
    ).catchError((e, s) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        isCancel = true;
      }

      kPrint("$e\n$s");

      closeRequest(cancelToken!);

      return Response(requestOptions: RequestOptions());
    });

    if (isCancel) {
      kPrint("CANCEL REQUEST");
      return AppResponse(statusCode: 451);
    }

    kPrint(
        "\n----------RESPONSE ID $idRequest----------"
            "\nDATA: ${res.data}"
            "\n------------------------------\n",
        'LOG-RESPONSE');

    if (isTimeOut) {
      return AppResponse(statusCode: 450);
    }

    return AppResponse(
      statusCode: res.statusCode,
      message: res.statusMessage,
      data: res.data,
    );
  }
}

enum _RequestType {
  get,
  post,
  put,
  delete,
}

enum ContentType {
  formUrlEncoded,
  json,
}
