part of '_routers.dart';

@TypedGoRoute<SplashRoute>(
  path: '/',
)
class SplashRoute extends GoRouteData {
  const SplashRoute({this.fromPage});

  final String? fromPage;

  @override
  Widget build(BuildContext context, GoRouterState state) => DemoView(title: fromPage ?? "Splash");
}

@TypedGoRoute<LoginRoute>(
  path: '/login',
)
class LoginRoute extends GoRouteData {
  const LoginRoute({this.fromPage});

  final String? fromPage;

  @override
  CustomTransitionPage buildPage(BuildContext context, GoRouterState state) => DemoView(title: fromPage.value)._addTransitionAnimation(state);
}
