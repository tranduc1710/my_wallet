import 'dart:math' as math;

import '../../../core/base/base.dart';

class HeaderDate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double min, max;

  HeaderDate({
    required this.child,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => math.max(max, min);

  @override
  double get minExtent => min;

  @override
  bool shouldRebuild(HeaderDate oldDelegate) {
    return child != oldDelegate.child || max != oldDelegate.max || min != oldDelegate.min;
  }
}
