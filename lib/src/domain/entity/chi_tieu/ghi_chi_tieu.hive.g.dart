// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ghi_chi_tieu.hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GhiChiTieuModelAdapter extends TypeAdapter<GhiChiTieuModel> {
  @override
  final int typeId = 6;

  @override
  GhiChiTieuModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GhiChiTieuModel(
      loaiChiTieu: fields[0] as int?,
      soTien: fields[1] as String?,
      codeTienTe: fields[2] as String?,
      donVi: fields[3] as String?,
      ghiChu: fields[4] as String?,
      chiTieu: fields[5] as ChiTieuModel?,
      choVay: fields[6] as ChoVayModel?,
      nhanTien: fields[7] as NhanTienModel?,
      id: fields[8] as int?,
      ngay: fields[9] as String?,
      gio: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GhiChiTieuModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.loaiChiTieu)
      ..writeByte(1)
      ..write(obj.soTien)
      ..writeByte(2)
      ..write(obj.codeTienTe)
      ..writeByte(3)
      ..write(obj.donVi)
      ..writeByte(4)
      ..write(obj.ghiChu)
      ..writeByte(5)
      ..write(obj.chiTieu)
      ..writeByte(6)
      ..write(obj.choVay)
      ..writeByte(7)
      ..write(obj.nhanTien)
      ..writeByte(8)
      ..write(obj.id)
      ..writeByte(9)
      ..write(obj.ngay)
      ..writeByte(10)
      ..write(obj.gio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GhiChiTieuModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
