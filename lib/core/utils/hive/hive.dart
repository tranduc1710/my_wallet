import 'package:hive_flutter/hive_flutter.dart';

import '../../../src/domain/entity/hive/locale.hive.dart';
import 'hive.enum.dart';

/// không tạo thêm box
/// chỉ dùng 1 box constant lưu những giá trị đơn giản hoặc cẩn bảo mật. Dữ liệu phức tạp hơn thì sử dụng sqlite
mixin AppHive<T> {
  static const String _keyBoxConstant = 'constant';

  static late Box _boxConstant;

  static Future init() async {
    await Hive.initFlutter();

    //đăng ký adapter
    _registerAdapter();

    //open box hive
    _boxConstant = await Hive.openBox(_keyBoxConstant);
  }

  static void _registerAdapter() {
    final adapter = LocaleHiveAdapter();
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }
  }

  static O? getConstant<O>(HiveBoxConstant key) {
    final value = _boxConstant.get(key.name);

    if (value is O) {
      return value;
    }

    return null;
  }

  /// chỉ lưu kiểu dữ liệu nguyên thủy như bool, int, double, String. Không lưu dạng khác
  static Future<void> setConstant<O>(HiveBoxConstant key, O value) {
    return _boxConstant.put(key.name, value);
  }

  static Future<void> deleteConstant(HiveBoxConstant key) {
    return _boxConstant.delete(key.name);
  }

  static Future<void> deleteAllConstant(List<HiveBoxConstant> lstKey) async {
    if (_boxConstant.isEmpty) return;
    await _boxConstant.deleteAll(lstKey.map((e) => e.name));
  }
}
