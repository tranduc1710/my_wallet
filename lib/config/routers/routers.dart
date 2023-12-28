import 'package:base_flutter/feature/demo/presentation/pages/demo_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

mixin AppRouter {
  static final router = [
    GoRoute(
      path: '/',
      builder: (context, state) => const DemoView(title: "Init"),
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => const DemoView(title: "Home").addTransitionAnimation(state),
    ),
  ];
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
