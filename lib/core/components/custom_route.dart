import 'package:flutter/cupertino.dart';

import '../utils/routers.dart';
import '../utils/utils.dart';

class CustomRoute extends PageRouteBuilder {
  CustomRoute({
    required Widget widget,
    required AppRouters routers,
    required Object? arguments,
  }) : super(
            settings: RouteSettings(name: routers.name, arguments: arguments),
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => widget,
            transitionDuration: Constant.timeAnimationShort,
            reverseTransitionDuration: Constant.timeAnimationShort,
            transitionsBuilder: (context, animation, _, child) {
              const begin = Offset(1.0, 0);
              const end = Offset.zero;
              const curve = Curves.easeIn;

              var tween = Tween(
                begin: begin,
                end: end,
              ).chain(
                CurveTween(
                  curve: curve,
                ),
              );

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            });
}
