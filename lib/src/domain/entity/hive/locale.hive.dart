import 'package:hive/hive.dart';

part 'locale.hive.g.dart';

@HiveType(typeId: 0)
class LocaleHive {
  @HiveField(0)
  final String languageCode;
  @HiveField(1)
  final String nameCountries;
  @HiveField(2)
  final String pathAssets;

  LocaleHive({
    required this.languageCode,
    required this.nameCountries,
    required this.pathAssets,
  });
}
