// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loai_chi_tieu.hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoaiChiTieuModelAdapter extends TypeAdapter<LoaiChiTieuModel> {
  @override
  final int typeId = 1;

  @override
  LoaiChiTieuModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoaiChiTieuModel(
      loai: fields[0] as String,
      ten: fields[1] as String,
      id: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LoaiChiTieuModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.loai)
      ..writeByte(1)
      ..write(obj.ten)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoaiChiTieuModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
