import 'package:hive/hive.dart';

part 'tien_te.hive.g.dart';

@HiveType(typeId: 2)
class TienTeModel extends HiveObject {
  @HiveField(0)
  final String code;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String symbol;
  @HiveField(3)
  final String flag;
  @HiveField(4)
  final int decimalDigits;
  @HiveField(5)
  final String number;
  @HiveField(6)
  final String namePlural;
  @HiveField(7)
  final String thousandsSeparator;
  @HiveField(8)
  final String decimalSeparator;
  @HiveField(9)
  final bool spaceBetweenAmountAndSymbol;
  @HiveField(10)
  final bool symbolOnLeft;

  TienTeModel({
    required this.code,
    required this.name,
    required this.symbol,
    required this.flag,
    required this.decimalDigits,
    required this.number,
    required this.namePlural,
    required this.thousandsSeparator,
    required this.decimalSeparator,
    required this.spaceBetweenAmountAndSymbol,
    required this.symbolOnLeft,
  });

  factory TienTeModel.fromJson(Map<String, dynamic> json) => TienTeModel(
        code: json["code"] ?? '',
        name: json["name"] ?? '',
        symbol: json["symbol"] ?? '',
        flag: json["flag"] ?? '',
        decimalDigits: json["decimal_digits"] ?? 0,
        number: json["number"] ?? '',
        namePlural: json["name_plural"] ?? '',
        thousandsSeparator: json["thousands_separator"] ?? '',
        decimalSeparator: json["decimal_separator"] ?? '',
        spaceBetweenAmountAndSymbol: json["space_between_amount_and_symbol"] ?? '',
        symbolOnLeft: json["symbol_on_left"] ?? false,
      );
}
