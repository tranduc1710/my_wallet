import 'package:base_flutter/core/base/base.dart';
import 'package:base_flutter/src/presentation/pages/add_spend/add_spend.page.dart';
import 'package:base_flutter/src/presentation/pages/home/home.page.dart';
import 'package:base_flutter/src/presentation/pages/splash/splash.page.dart';
import 'package:go_router/go_router.dart';

part '_routers.g.dart';
part 'home.dart';
part 'spend.dart';
part 'unlogin.dart';

extension ExWidget on Widget {
  CustomTransitionPage _addTransitionAnimation(GoRouterState state) {
    return CustomTransitionPage(
      child: this,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOutCirc,
        )),
        child: AnimatedPhysicalModel(
          duration: Duration.zero,
          elevation: 50,
          shape: BoxShape.rectangle,
          shadowColor: Colors.black,
          color: Colors.white,
          child: child,
        ),
      ),
    );
  }
}
