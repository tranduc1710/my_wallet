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
  // MobileAds.instance.initialize();
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
    AppHive.boxConstant.put(HiveBoxConstant.language.name, localeHive);
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
        useMaterial3: false,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColor.primary,
          onPrimary: AppColor.textIcon,
          secondary: AppColor.accent,
          onSecondary: AppColor.accent,
          error: AppColor.error,
          onError: AppColor.error,
          background: AppColor.textIcon,
          onBackground: AppColor.primaryText,
          surface: AppColor.textIcon,
          onSurface: AppColor.primaryText,
        ),
        appBarTheme: AppBarTheme(
          elevation: 10,
          backgroundColor: AppColor.primary,
          centerTitle: true,
          titleTextStyle: AppStyle.s18.copyWith(
            color: AppColor.textIcon,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: AppColor.textIcon,
          ),
          actionsIconTheme: IconThemeData(
            color: AppColor.textIcon,
          ),
        ),
      );

  ThemeData get darkTheme => ThemeData(
        fontFamily: 'Roboto',
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.black,
        ),
        dividerColor: AppColor.divider,
        primaryColorDark: AppColor.darkPrimary,
        primaryColorLight: AppColor.lightPrimary,
        brightness: Brightness.dark,
        useMaterial3: false,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.primary,
          centerTitle: true,
        ),
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
