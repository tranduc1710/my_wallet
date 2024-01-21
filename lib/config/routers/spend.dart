part of '_routers.dart';

class AddSpendRoute extends GoRouteData {
  @override
  CustomTransitionPage buildPage(BuildContext context, GoRouterState state) =>
      const AddSpendPage(isAdd: true)._addTransitionAnimation(state);
}

class RemoveSpendRoute extends GoRouteData {
  @override
  CustomTransitionPage buildPage(BuildContext context, GoRouterState state) =>
      const AddSpendPage(isAdd: false)._addTransitionAnimation(state);
}
