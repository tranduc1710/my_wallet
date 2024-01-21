import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'config/routers/_routers.dart';
import 'core/base/base.dart';
import 'core/utils/utils.dart';
import 'generated/l10n.dart';

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

  final router = GoRouter(
    routes: $appRoutes,
    navigatorKey: Constant.navigatorKey,
    redirect: (context, state) {
      return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return MaterialApp.router(
      title: "Demo project",
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      scaffoldMessengerKey: Constant.scaffoldMessengerKey,
      locale: const Locale.fromSubtags(languageCode: 'en'),
      theme: ThemeData(
        fontFamily: 'OpenSans',
        useMaterial3: false,
      ),
    );
  }
}
