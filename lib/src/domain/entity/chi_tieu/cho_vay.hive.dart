import 'dart:convert';

import 'package:hive/hive.dart';

part 'cho_vay.hive.g.dart';

@HiveType(typeId: 4)
class ChoVayModel extends HiveObject {
  @HiveField(0)
  final int? nguoiVay;
  @HiveField(1)
  final String? ngayTraNo;
  @HiveField(2)
  final String? gioTraNo;
  @HiveField(3)
  final int? laiSuat;
  @HiveField(4)
  final String? tienLaiSuat;
  @HiveField(5)
  final String? phanTramLai;
  @HiveField(6)
  final int? donViLaiPt;
  @HiveField(7)
  final bool? laDiVay;

  ChoVayModel({
    this.nguoiVay,
    this.ngayTraNo,
    this.gioTraNo,
    this.laiSuat,
    this.tienLaiSuat,
    this.phanTramLai,
    this.donViLaiPt,
    this.laDiVay,
  });

  factory ChoVayModel.fromRawJson(String str) => ChoVayModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChoVayModel.fromJson(Map<String, dynamic> json) => ChoVayModel(
        nguoiVay: json["nguoiVay"],
        ngayTraNo: json["ngayTraNo"],
        gioTraNo: json["gioTraNo"],
        laiSuat: json["laiSuat"],
        tienLaiSuat: json["tienLaiSuat"],
        phanTramLai: json["phanTramLai"],
        donViLaiPt: json["donViLaiPT"],
        laDiVay: json["laDiVay"],
      );

  Map<String, dynamic> toJson() => {
        "nguoiVay": nguoiVay,
        "ngayTraNo": ngayTraNo,
        "gioTraNo": gioTraNo,
        "laiSuat": laiSuat,
        "tienLaiSuat": tienLaiSuat,
        "phanTramLai": phanTramLai,
        "donViLaiPT": donViLaiPt,
        "laDiVay": laDiVay,
      };
}
