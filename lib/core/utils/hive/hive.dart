import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_wallet/src/domain/entity/chi_tieu/chi_tieu.hive.dart';
import 'package:my_wallet/src/domain/entity/chi_tieu/cho_vay.hive.dart';
import 'package:my_wallet/src/domain/entity/chi_tieu/ghi_chi_tieu.hive.dart';
import 'package:my_wallet/src/domain/entity/chi_tieu/nhan_tien.hive.dart';
import 'package:my_wallet/src/domain/entity/hive/loai_chi_tieu.hive.dart';
import 'package:my_wallet/src/domain/entity/hive/tien_te.hive.dart';

import '../../../src/domain/entity/hive/locale.hive.dart';
import 'hive.enum.dart';

mixin AppHive<T> {
  static late final Box boxConstant;

  static late final Box<LoaiChiTieuModel> boxLoaiChiTieu;

  static late final Box<TienTeModel> boxTienTe;

  static late final Box<LoaiChiTieuModel> boxNguoiVay;

  static late final Box<LoaiChiTieuModel> boxNhanTu;

  static late final Box<GhiChiTieuModel> boxChiTieu;

  static Future init() async {
    await Hive.initFlutter();

    //đăng ký adapter
    _registerAdapter();

    //open box hive
    boxConstant = await Hive.openBox(HiveBox.constant.name);
    boxLoaiChiTieu = await Hive.openBox<LoaiChiTieuModel>(HiveBox.loaiChiTieu.name);
    boxTienTe = await Hive.openBox<TienTeModel>(HiveBox.danhSachTienTe.name);
    boxNguoiVay = await Hive.openBox<LoaiChiTieuModel>(HiveBox.danhSachNguoiVay.name);
    boxNhanTu = await Hive.openBox<LoaiChiTieuModel>(HiveBox.danhSachNhanTu.name);
    boxChiTieu = await Hive.openBox<GhiChiTieuModel>(HiveBox.danhSachChiTieu.name);
  }

  static void _registerAdapter() {
    if (!Hive.isAdapterRegistered(LocaleHiveAdapter().typeId)) {
      Hive.registerAdapter(LocaleHiveAdapter());
    }
    if (!Hive.isAdapterRegistered(LoaiChiTieuModelAdapter().typeId)) {
      Hive.registerAdapter(LoaiChiTieuModelAdapter());
    }
    if (!Hive.isAdapterRegistered(TienTeModelAdapter().typeId)) {
      Hive.registerAdapter(TienTeModelAdapter());
    }
    if (!Hive.isAdapterRegistered(ChiTieuModelAdapter().typeId)) {
      Hive.registerAdapter(ChiTieuModelAdapter());
    }
    if (!Hive.isAdapterRegistered(ChoVayModelAdapter().typeId)) {
      Hive.registerAdapter(ChoVayModelAdapter());
    }
    if (!Hive.isAdapterRegistered(GhiChiTieuModelAdapter().typeId)) {
      Hive.registerAdapter(GhiChiTieuModelAdapter());
    }
    if (!Hive.isAdapterRegistered(NhanTienModelAdapter().typeId)) {
      Hive.registerAdapter(NhanTienModelAdapter());
    }
  }

// static O? getConstant<O>(HiveBoxConstant key) {
//   final value = _boxConstant.get(key.name);
//
//   if (value is O) {
//     return value;
//   }
//
//   return null;
// }
//
// static Future<void> setConstant<O>(HiveBoxConstant key, O value) {
//   return _boxConstant.put(key.name, value);
// }
//
// static Future<void> deleteConstant(HiveBoxConstant key) {
//   return _boxConstant.delete(key.name);
// }
//
// static Future<void> deleteAllConstant(List<HiveBoxConstant> lstKey) async {
//   if (_boxConstant.isEmpty) return;
//   await _boxConstant.deleteAll(lstKey.map((e) => e.name));
// }
}
