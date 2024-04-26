import 'package:base_flutter/src/presentation/pages/home/home_view.dart';
import 'package:flutter/material.dart';

import '../../src/presentation/pages/add_spend/add_spend_view.dart';
import '../../src/presentation/pages/splash/splash_view.dart';
import '../components/custom_route.dart';

enum AppRouters implements Comparable<AppRouters> {
  splash(name: '/', build: SplashPage()),
  home(name: '/home', build: HomePage()),
  addSpend(name: '/addSpend', build: AddSpendPage(isAdd: true)),
  editSpend(name: '/editSpend', build: AddSpendPage(isAdd: false)),
  ;

  final String name;
  final Widget build;

  const AppRouters({
    required this.name,
    required this.build,
  });

  Future push<T>(
    BuildContext context, {
    Object? arguments,
  }) async {
    await Navigator.of(context).push(CustomRoute(
      widget: build,
      routers: this,
      arguments: arguments,
    ));
  }

  Future pushReplacement<T>(
    BuildContext context, {
    T? result,
    Object? arguments,
  }) async {
    await Navigator.of(context).pushReplacement(CustomRoute(
      widget: build,
      routers: this,
      arguments: arguments,
    ));
  }

  Future pushAndRemoveUntil<T>(
    BuildContext context,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) async {
    await Navigator.of(context).pushAndRemoveUntil(
      CustomRoute(
        widget: build,
        routers: this,
        arguments: arguments,
      ),
      (route) => false,
    );
  }

  @override
  int compareTo(AppRouters other) => compareTo(other);
}
