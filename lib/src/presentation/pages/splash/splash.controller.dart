import 'package:base_flutter/config/routers/_routers.dart';
import 'package:base_flutter/core/base/base.dart';

class SplashController {
  void init() async {
    await 1.delayed();
    if (context.mounted) {
      const HomeRoute().go(context);
    }
  }
}
