part of 'utils.dart';

mixin AppEdgeInsets {
  static EdgeInsets get popup => EdgeInsets.symmetric(horizontal: 20.dm, vertical: 10.dm);

  static EdgeInsets get item => EdgeInsets.all(7.dm);

  static EdgeInsets get screen => EdgeInsets.symmetric(horizontal: 15.dm, vertical: 5.dm);

  static EdgeInsets get vertical => EdgeInsets.symmetric(vertical: 5.dm);

  static EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: 5.dm);

  static EdgeInsets get top => EdgeInsets.only(top: 5.dm);

  static EdgeInsets get bottom => EdgeInsets.only(bottom: 5.dm);

  static EdgeInsets get left => EdgeInsets.only(left: 5.dm);

  static EdgeInsets get right => EdgeInsets.only(right: 5.dm);
}
