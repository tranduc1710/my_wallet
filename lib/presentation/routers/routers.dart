import 'package:base_flutter/presentation/pages/demo/demo_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routers.g.dart';

@TypedGoRoute<DemoRoute>(
  path: '/',
)
class DemoRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const DemoView(title: "Init router");
}

@TypedGoRoute<HomeRoute>(
  path: '/home',
)
class HomeRoute extends GoRouteData {
  final String title;

  HomeRoute(this.title);

  @override
  CustomTransitionPage buildPage(BuildContext context, GoRouterState state) =>
      DemoView(title: title).addTransitionAnimation(state);
}

extension _ExWidget on Widget {
  CustomTransitionPage addTransitionAnimation(GoRouterState state) {
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
