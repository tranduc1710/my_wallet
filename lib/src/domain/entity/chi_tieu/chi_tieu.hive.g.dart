// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chi_tieu.hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChiTieuModelAdapter extends TypeAdapter<ChiTieuModel> {
  @override
  final int typeId = 5;

  @override
  ChiTieuModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChiTieuModel(
      loaiChiTieu: fields[0] as int?,
      fullNgayGio: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ChiTieuModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.loaiChiTieu)
      ..writeByte(1)
      ..write(obj.fullNgayGio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChiTieuModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
