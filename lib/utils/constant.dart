part of 'utils.dart';

abstract class Constant {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static SessionModel? session;

  static String get pathApi => "https://dms.smac.com.vn:8440/";

  static String get clientSecret => "NBiJ2aCTS65haei0iWhVepd122XI2xfd";

  static Duration get timeRequest => const Duration(seconds: 30);

  static double get radius => 7.0;
}
