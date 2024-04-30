// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nhan_tien.hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NhanTienModelAdapter extends TypeAdapter<NhanTienModel> {
  @override
  final int typeId = 3;

  @override
  NhanTienModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NhanTienModel(
      nhanTu: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, NhanTienModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.nhanTu);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NhanTienModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
