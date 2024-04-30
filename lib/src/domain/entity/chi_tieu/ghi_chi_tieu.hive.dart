import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:my_wallet/src/domain/entity/chi_tieu/chi_tieu.hive.dart';
import 'package:my_wallet/src/domain/entity/chi_tieu/cho_vay.hive.dart';
import 'package:my_wallet/src/domain/entity/chi_tieu/nhan_tien.hive.dart';

part 'ghi_chi_tieu.hive.g.dart';

@HiveType(typeId: 6)
class GhiChiTieuModel extends HiveObject {
  @HiveField(0)
  final int? loaiChiTieu;
  @HiveField(1)
  final String? soTien;
  @HiveField(2)
  final String? codeTienTe;
  @HiveField(3)
  final String? donVi;
  @HiveField(4)
  final String? ghiChu;
  @HiveField(5)
  final ChiTieuModel? chiTieu;
  @HiveField(6)
  final ChoVayModel? choVay;
  @HiveField(7)
  final NhanTienModel? nhanTien;
  @HiveField(8)
  final int? id;
  @HiveField(9)
  final String? ngay;
  @HiveField(10)
  final String? gio;

  GhiChiTieuModel({
    this.loaiChiTieu,
    this.soTien,
    this.codeTienTe,
    this.donVi,
    this.ghiChu,
    this.chiTieu,
    this.choVay,
    this.nhanTien,
    this.id,
    this.ngay,
    this.gio,
  });

  factory GhiChiTieuModel.fromRawJson(String str) => GhiChiTieuModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GhiChiTieuModel.fromJson(Map<String, dynamic> json) => GhiChiTieuModel(
        id: json["id"],
        loaiChiTieu: json["loaiChiTieu"],
        soTien: json["soTien"],
        codeTienTe: json["codeTienTe"],
        donVi: json["donVi"],
        ghiChu: json["ghiChu"],
        gio: json["gio"],
        ngay: json["ngay"],
        chiTieu: json["chiTieu"] == null ? null : ChiTieuModel.fromJson(json["chiTieu"]),
        choVay: json["choVay"] == null ? null : ChoVayModel.fromJson(json["choVay"]),
        nhanTien: json["nhanTien"] == null ? null : NhanTienModel.fromJson(json["nhanTien"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "loaiChiTieu": loaiChiTieu,
        "soTien": soTien,
        "codeTienTe": codeTienTe,
        "donVi": donVi,
        "ghiChu": ghiChu,
        "gio": gio,
        "ngay": ngay,
        "chiTieu": chiTieu?.toJson(),
        "choVay": choVay?.toJson(),
        "nhanTien": nhanTien?.toJson(),
      };
}
