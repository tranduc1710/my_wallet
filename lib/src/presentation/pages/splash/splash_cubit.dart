import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:my_wallet/core/utils/hive/hive.dart';
import 'package:my_wallet/core/utils/routers.dart';
import 'package:my_wallet/src/domain/entity/hive/tien_te.hive.dart';

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

  void _init() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) async {
      await AppHive.init();
      await setupData();
      await 1.delayed();
      AppRouters.home.pushAndRemoveUntil(context, (p0) => false);
    });
  }

  Future<void> setupData() async {
    final lstTienTe = AppHive.boxTienTe.values.toList();

    if (lstTienTe.isEmpty) {
      final rawJson = await rootBundle.loadString('assets/config/currency.json');
      final lstRaw = jsonDecode(rawJson) as List;

      lstTienTe.addAll(lstRaw.map((e) => TienTeModel.fromJson(e)));

      lstTienTe.sort((a, b) => a.code.compareTo(b.code));

      AppHive.boxTienTe.addAll(lstTienTe);
    }
  }
}
