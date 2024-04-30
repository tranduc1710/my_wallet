// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cho_vay.hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChoVayModelAdapter extends TypeAdapter<ChoVayModel> {
  @override
  final int typeId = 4;

  @override
  ChoVayModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChoVayModel(
      nguoiVay: fields[0] as int?,
      ngayTraNo: fields[1] as String?,
      gioTraNo: fields[2] as String?,
      laiSuat: fields[3] as int?,
      tienLaiSuat: fields[4] as String?,
      phanTramLai: fields[5] as String?,
      donViLaiPt: fields[6] as int?,
      laDiVay: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ChoVayModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.nguoiVay)
      ..writeByte(1)
      ..write(obj.ngayTraNo)
      ..writeByte(2)
      ..write(obj.gioTraNo)
      ..writeByte(3)
      ..write(obj.laiSuat)
      ..writeByte(4)
      ..write(obj.tienLaiSuat)
      ..writeByte(5)
      ..write(obj.phanTramLai)
      ..writeByte(6)
      ..write(obj.donViLaiPt)
      ..writeByte(7)
      ..write(obj.laDiVay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChoVayModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
