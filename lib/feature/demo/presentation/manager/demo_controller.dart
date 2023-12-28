import 'dart:async';

import 'package:base_flutter/feature/demo/presentation/manager/demo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/base/base.dart';

///class này chỉ khai báo biến, xử lý hiển thị lên view
///là cầu nối giao tiếp giữa view và view model
///không xử lý logic ở đây
class DemoController {
  final viewModel = DemoViewModel();

  final tfController = TextEditingController();
  late final Timer timer;

  void init() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      kPrint(DateTime.now().toIso8601String());
    });
  }

  ///- Mỗi 1 stream hay listen đều phải cancel vào đây
  ///- Các controller cũng phải dispose. Nếu là TextEditingController và sử dụng AppTextField
  ///thì không cần dispose
  ///- Nếu không đóng lại sẽ bị leak memory
  void dispose() {
    kPrint("Close $this");
    timer.cancel();
  }

  void nextPage() {
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => DemoView(title: "Home router"),
    // ));
    context.push('/home');
  }
}
