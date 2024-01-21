part of '_routers.dart';

@TypedGoRoute<HomeRoute>(
  path: '/home',
  routes: [
    TypedGoRoute<AddSpendRoute>(
      path: 'addSpend',
    ),
    TypedGoRoute<RemoveSpendRoute>(
      path: 'removeSpend',
    ),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  CustomTransitionPage buildPage(BuildContext context, GoRouterState state) => const HomePage()._addTransitionAnimation(state);
}
