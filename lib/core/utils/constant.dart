part of 'utils.dart';

mixin Constant {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static SessionEntity? session;

  static String get pathApi => "https://dms.smac.com.vn:8440/";

  static String get clientSecret => "NBiJ2aCTS65haei0iWhVepd122XI2xfd";

  static Duration get timeRequest => const Duration(seconds: 30);

  static double get radius => 7.0;
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
}
