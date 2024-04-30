// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tien_te.hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TienTeModelAdapter extends TypeAdapter<TienTeModel> {
  @override
  final int typeId = 2;

  @override
  TienTeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TienTeModel(
      code: fields[0] as String,
      name: fields[1] as String,
      symbol: fields[2] as String,
      flag: fields[3] as String,
      decimalDigits: fields[4] as int,
      number: fields[5] as String,
      namePlural: fields[6] as String,
      thousandsSeparator: fields[7] as String,
      decimalSeparator: fields[8] as String,
      spaceBetweenAmountAndSymbol: fields[9] as bool,
      symbolOnLeft: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TienTeModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.symbol)
      ..writeByte(3)
      ..write(obj.flag)
      ..writeByte(4)
      ..write(obj.decimalDigits)
      ..writeByte(5)
      ..write(obj.number)
      ..writeByte(6)
      ..write(obj.namePlural)
      ..writeByte(7)
      ..write(obj.thousandsSeparator)
      ..writeByte(8)
      ..write(obj.decimalSeparator)
      ..writeByte(9)
      ..write(obj.spaceBetweenAmountAndSymbol)
      ..writeByte(10)
      ..write(obj.symbolOnLeft);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TienTeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
