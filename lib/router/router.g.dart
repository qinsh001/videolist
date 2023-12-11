// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $topRoute,
      $searchResultRoute,
      $searchRoute,
      $videoDetailRoute,
    ];

RouteBase get $topRoute => GoRouteData.$route(
      path: '/homePage',
      factory: $TopRouteExtension._fromState,
    );

extension $TopRouteExtension on TopRoute {
  static TopRoute _fromState(GoRouterState state) => const TopRoute();

  String get location => GoRouteData.$location(
        '/homePage',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $searchResultRoute => GoRouteData.$route(
      path: '/searchResult',
      factory: $SearchResultRouteExtension._fromState,
    );

extension $SearchResultRouteExtension on SearchResultRoute {
  static SearchResultRoute _fromState(GoRouterState state) => SearchResultRoute(
        state.uri.queryParameters['title']!,
      );

  String get location => GoRouteData.$location(
        '/searchResult',
        queryParams: {
          'title': title,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $searchRoute => GoRouteData.$route(
      path: '/search',
      factory: $SearchRouteExtension._fromState,
    );

extension $SearchRouteExtension on SearchRoute {
  static SearchRoute _fromState(GoRouterState state) => const SearchRoute();

  String get location => GoRouteData.$location(
        '/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $videoDetailRoute => GoRouteData.$route(
      path: '/videoDetail',
      factory: $VideoDetailRouteExtension._fromState,
    );

extension $VideoDetailRouteExtension on VideoDetailRoute {
  static VideoDetailRoute _fromState(GoRouterState state) => VideoDetailRoute(
        state.extra as ListItemJson,
      );

  String get location => GoRouteData.$location(
        '/videoDetail',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}
