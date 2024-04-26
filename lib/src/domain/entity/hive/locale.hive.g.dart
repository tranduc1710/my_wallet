// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale.hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocaleHiveAdapter extends TypeAdapter<LocaleHive> {
  @override
  final int typeId = 0;

  @override
  LocaleHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocaleHive(
      languageCode: fields[0] as String,
      nameCountries: fields[1] as String,
      pathAssets: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocaleHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.languageCode)
      ..writeByte(1)
      ..write(obj.nameCountries)
      ..writeByte(2)
      ..write(obj.pathAssets);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocaleHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
