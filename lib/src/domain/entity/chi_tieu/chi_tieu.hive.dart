import 'dart:convert';

import 'package:hive/hive.dart';

part 'chi_tieu.hive.g.dart';

@HiveType(typeId: 5)
class ChiTieuModel extends HiveObject {
  @HiveField(0)
  final int? loaiChiTieu;
  @HiveField(1)
  final int? fullNgayGio;

  ChiTieuModel({
    this.loaiChiTieu,
    this.fullNgayGio,
  });

  factory ChiTieuModel.fromRawJson(String str) => ChiTieuModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChiTieuModel.fromJson(Map<String, dynamic> json) => ChiTieuModel(
        loaiChiTieu: json["loaiChiTieu"],
        fullNgayGio: json["fullNgayGio"],
      );

  Map<String, dynamic> toJson() => {
        "loaiChiTieu": loaiChiTieu,
        "fullNgayGio": fullNgayGio,
      };
}
