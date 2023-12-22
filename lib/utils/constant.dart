part of 'utils.dart';

abstract class Constant {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Duration get timeRequest => const Duration(seconds: 30);

  static double get radius => 7.0;
}
