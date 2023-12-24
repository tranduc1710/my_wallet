import 'dart:async';

import 'package:base_flutter/presentation/pages/demo/demo_view_model.dart';
import 'package:base_flutter/presentation/routers/routers.dart';

import '../../../base/base.dart';

///class này chỉ khai báo biến, xử lý hiển thị lên view
///là cầu nối giao tiếp giữa view và view model
///không xử lý logic ở đây
class DemoController {
  final viewModel = DemoViewModel();

  late final Timer timer;

  void init() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      kPrint(DateTime.now().toIso8601String());
    });
  }

  ///mỗi 1 stream hay listen đều phải cancel vào đây
  ///các TextEditingController cũng phải dispose
  ///nếu không đóng lại sẽ bị lưu vào bộ nhớ và tiêu tốn tài nguyên
  void dispose() {
    kPrint("Close $this");
    timer.cancel();
  }

  void nextPage() {
    HomeRoute("Home router").push(context);
  }
}
