part of '_routers.dart';

@TypedGoRoute<ListProductRoute>(
  path: '/home/product',
)
class ListProductRoute extends GoRouteData {
  const ListProductRoute({this.fromPage});

  final String? fromPage;

  @override
  CustomTransitionPage buildPage(BuildContext context, GoRouterState state) => DemoView(title: fromPage.value)._addTransitionAnimation(state);
}

@TypedGoRoute<DetailProductRoute>(
  path: '/home/product/detail',
)
class DetailProductRoute extends GoRouteData {
  const DetailProductRoute({this.fromPage});

  final String? fromPage;

  @override
  CustomTransitionPage buildPage(BuildContext context, GoRouterState state) => DemoView(title: fromPage.value)._addTransitionAnimation(state);
}
