import 'dart:async';

import 'package:base_flutter/config/routers/_routers.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';

import '../../../../core/base/base.dart';

///class này chỉ khai báo biến, xử lý hiển thị lên view
///là cầu nối giao tiếp giữa view và view model
///không xử lý logic ở đây
class DemoController {
  final tfController = TextEditingController();
  late final Timer timer;

  BehaviorSubject<bool> rxLoading = true.rx;

  void init() async {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      kPrint(DateTime.now().toIso8601String());
    });
    await 3.delayed();
    rxLoading.value = false;
  }

  ///- Mỗi 1 stream hay listen đều phải cancel vào đây
  ///- Các controller cũng phải dispose. Nếu là TextEditingController và sử dụng AppTextField
  ///thì không cần dispose
  ///- Nếu không đóng lại sẽ bị leak memory
  void dispose() {
    kPrint("Close $this");
    timer.cancel();
  }
}

extension ExFunction on DemoController {
  void nextPage() {
    LoginRoute(fromPage: 'Init ${DateTime.now().toIso8601String()}').push(context);
  }
}
