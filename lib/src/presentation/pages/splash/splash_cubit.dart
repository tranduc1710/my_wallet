import 'package:base_flutter/core/utils/routers.dart';
import 'package:bloc/bloc.dart';

import '../../../../core/base/base.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final BuildContext context;
  SplashCubit(this.context) : super(SplashState().init()) {
    _init();
  }

  @override
  Future<void> close() {
    kPrint("CLOSE $runtimeType");
    return super.close();
  }

  void _init() async {
    await 1.delayed();
    AppRouters.home.pushAndRemoveUntil(context, (p0) => false);
  }
}
