import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/base/base.dart';
import 'core/utils/hive/hive.dart';
import 'core/utils/hive/hive.enum.dart';
import 'core/utils/routers.dart';
import 'core/utils/utils.dart';
import 'generated/l10n.dart';
import 'src/domain/entity/hive/locale.hive.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Map<String, Widget Function(BuildContext)> routers = AppRouters.values.asMap().map(
    (key, value) {
      return MapEntry(
        value.name,
        (context) => value.build,
      );
    },
  ).cast();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BlocProvider(
      create: (_) => AppCubit(_AppState()),
      child: BlocBuilder<AppCubit, _AppState>(
        builder: (_, state) {
          return MaterialApp(
            navigatorKey: Constant.navigatorKey,
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (context) => AppLanguage.appName,
            theme: state.themeData,
            routes: routers,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: Locale(state.localeHive.languageCode),
          );
        },
      ),
    );
  }
}

class AppCubit extends Cubit<_AppState> {
  AppCubit(super.initialState);

  void toggleTheme() {
    if (state.brightness == Brightness.dark) {
      state.themeData = state.lightTheme;
      state.brightness = Brightness.light;
    } else {
      state.themeData = state.darkTheme;
      state.brightness = Brightness.dark;
    }

    emit(state.copyTheme());
  }

  void changeLanguage(BuildContext context, LocaleHive localeHive, [bool onSplash = false]) {
    AppHive.setConstant(HiveBoxConstant.language, localeHive);
    emit(state.copyLanguage(localeHive: localeHive));
    if (!onSplash) {
      AppRouters.splash.pushAndRemoveUntil(context, (p0) => false);
    }
  }
}

class _AppState {
  late ThemeData themeData;
  late Brightness brightness;
  late LocaleHive localeHive;

  ThemeData get lightTheme => ThemeData(
        fontFamily: 'Roboto',
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
        brightness: Brightness.light,
        useMaterial3: false,
        primaryColor: AppColor.primary,
        scaffoldBackgroundColor: AppColor.textIcon,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: AppColor.primary,
          centerTitle: true,
          titleTextStyle: AppStyle.s18.copyWith(
            color: AppColor.textIcon,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  ThemeData get darkTheme => ThemeData(
        fontFamily: 'Roboto',
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.black,
        ),
        brightness: Brightness.dark,
        useMaterial3: false,
      );

  _AppState({
    LocaleHive? localeHive,
    ThemeData? themeData,
    Brightness? brightness,
  }) {
    this.localeHive = localeHive ?? Constant.lstCountries.first;
    this.themeData = themeData ?? lightTheme;
    this.brightness = brightness ?? Brightness.light;
  }

  _AppState copyTheme({
    ThemeData? themeData,
    Brightness? brightness,
  }) =>
      _AppState(
        localeHive: localeHive,
        themeData: themeData ?? this.themeData,
        brightness: brightness ?? this.brightness,
      );

  _AppState copyLanguage({
    LocaleHive? localeHive,
  }) =>
      _AppLanguageState(
        localeHive: localeHive ?? this.localeHive,
        themeData: themeData,
        brightness: brightness,
      );
}

class _AppLanguageState extends _AppState {
  _AppLanguageState({
    super.localeHive,
    super.brightness,
    super.themeData,
  });
}
