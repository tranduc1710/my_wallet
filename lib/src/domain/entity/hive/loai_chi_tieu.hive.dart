import 'package:hive/hive.dart';

part 'loai_chi_tieu.hive.g.dart';

@HiveType(typeId: 1)
class LoaiChiTieuModel extends HiveObject {
  @HiveField(0)
  final String loai;
  @HiveField(1)
  final String ten;
  @HiveField(2)
  final int id;

  LoaiChiTieuModel({
    required this.loai,
    required this.ten,
    required this.id,
  });
}
