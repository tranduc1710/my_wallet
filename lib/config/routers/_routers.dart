import 'package:base_flutter/core/base/base.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../src/presentation/pages/demo/demo.page.dart';

part 'unlogin.dart';
part 'product.dart';
part '_routers.g.dart';

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
