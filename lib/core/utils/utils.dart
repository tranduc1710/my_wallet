import 'package:my_wallet/core/base/base.dart';

import '../../src/domain/entity/hive/locale.hive.dart';
import '../../src/presentation/pages/add_spend/add_spend_view.dart';

part 'color.dart';
part 'constant.dart';
part 'edge_insets.dart';
part 'style.dart';

abstract class Utils {
  static String formatMoney(double money, [bool addTT = true]) {
    final lstSplit = money.abs().toString().split('.');
    final lst = [];
    final soTien = lstSplit.first.replaceAll(',', '');
    final soDu = soTien.length % 3;

    for (var i = soTien.length ~/ 3; i > 0; i--) {
      if (i * 3 - 3 + soDu < 0) continue;

      lst.insert(0, soTien.substring(i * 3 - 3 + soDu, i * 3 + soDu));
    }
    if (soDu != 0) {
      lst.insert(0, soTien.substring(0, soDu));
    }
    return "${addTT ? (money < 0 ? "-" : "+") : ""}${lst.join(',')}${lstSplit.length > 1 ? ".${lstSplit.last}" : ''}";
  }
}
