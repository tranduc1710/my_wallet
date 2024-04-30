import 'dart:convert';

import 'package:hive/hive.dart';

part 'nhan_tien.hive.g.dart';

@HiveType(typeId: 3)
class NhanTienModel extends HiveObject {
  @HiveField(0)
  final int? nhanTu;

  NhanTienModel({
    this.nhanTu,
  });

  factory NhanTienModel.fromRawJson(String str) => NhanTienModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NhanTienModel.fromJson(Map<String, dynamic> json) => NhanTienModel(
        nhanTu: json["nhanTu"],
      );

  Map<String, dynamic> toJson() => {
        "nhanTu": nhanTu,
      };
}
