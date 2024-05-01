part of 'utils.dart';

mixin Constant {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static String get pathApi => '';

  static Duration get timeRequest => const Duration(seconds: 30);
  static Duration timeAnimationShort = const Duration(milliseconds: 400);
  static Duration timeAnimationLong = const Duration(milliseconds: 800);

  static double get radius => 7.0;
  static final lstCountries = [
    LocaleHive(
      languageCode: 'en',
      nameCountries: 'English',
      pathAssets: 'assets/icons/tieng_anh.png',
    ),
    LocaleHive(
      languageCode: 'vi',
      nameCountries: 'Việt Nam',
      pathAssets: 'assets/icons/tieng_viet.png',
    ),
  ];
  static final lstTimeLaiSuat = [
    (text: AppLanguage.nam, index: TypeLaiSuat.nam.index),
    (text: AppLanguage.thang, index: TypeLaiSuat.thang.index),
    (text: AppLanguage.ngay, index: TypeLaiSuat.ngay.index),
  ];
}
