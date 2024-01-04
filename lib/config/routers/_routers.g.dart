// GENERATED CODE - DO NOT MODIFY BY HAND

part of '_routers.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $loginRoute,
      $listProductRoute,
      $detailProductRoute,
    ];

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/',
      factory: $SplashRouteExtension._fromState,
    );

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => SplashRoute(
        fromPage: state.uri.queryParameters['from-page'],
      );

  String get location => GoRouteData.$location(
        '/',
        queryParams: {
          if (fromPage != null) 'from-page': fromPage,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginRouteExtension._fromState,
    );

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => LoginRoute(
        fromPage: state.uri.queryParameters['from-page'],
      );

  String get location => GoRouteData.$location(
        '/login',
        queryParams: {
          if (fromPage != null) 'from-page': fromPage,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $listProductRoute => GoRouteData.$route(
      path: '/home/product',
      factory: $ListProductRouteExtension._fromState,
    );

extension $ListProductRouteExtension on ListProductRoute {
  static ListProductRoute _fromState(GoRouterState state) => ListProductRoute(
        fromPage: state.uri.queryParameters['from-page'],
      );

  String get location => GoRouteData.$location(
        '/home/product',
        queryParams: {
          if (fromPage != null) 'from-page': fromPage,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $detailProductRoute => GoRouteData.$route(
      path: '/home/product/detail',
      factory: $DetailProductRouteExtension._fromState,
    );

extension $DetailProductRouteExtension on DetailProductRoute {
  static DetailProductRoute _fromState(GoRouterState state) =>
      DetailProductRoute(
        fromPage: state.uri.queryParameters['from-page'],
      );

  String get location => GoRouteData.$location(
        '/home/product/detail',
        queryParams: {
          if (fromPage != null) 'from-page': fromPage,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
