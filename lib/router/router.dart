import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:videolist/model/simple_models.dart';
import 'package:videolist/page/app/home_page.dart';
import 'package:videolist/page/app/video_detail_page.dart';
import 'package:videolist/page/app/video_page.dart';
import 'package:videolist/page/study/study_324.dart';
import 'package:videolist/page/study/study_one.dart';
import 'package:videolist/widget/error_page.dart';

part 'router.g.dart';

final GoRouter goRouter = GoRouter(
  routes: $appRoutes,
  initialLocation: RoutePath.home,
  errorPageBuilder: (context, state) => NoTransitionPage<void>(
    key: state.pageKey,
    child: const ErrorPage(),
  ),
);

extension GoRouterX on GoRouter {
  Future<T?> pushAndRemoveUntilX<T extends Object?>(
      String location, String popUtil,
      {Object? extra}) {
    routerDelegate.navigatorKey.currentState
        ?.popUntil(ModalRoute.withName(popUtil));
    return push(location, extra: extra);
  }

  //
  void popUntil(String location) {
    routerDelegate.navigatorKey.currentState
        ?.popUntil(ModalRoute.withName(location));
  }

  void singTopPush(String location, {Object? extra}) {
    pushReplacement(location, extra: extra);
  }

  bool hasLocation(String location) {
    return routerDelegate.currentConfiguration.matches
            .firstWhereOrNull((element) {
          return element.matchedLocation.contains(location);
        }) !=
        null;
  }
}

class RoutePath {
  RoutePath._();

  static const String home = '/homePage';
  static const String error404 = '/404';
  static const String login = '/login';
  static const String register = '/register';
  static const String search = '/search';
  static const String searchResult = '/searchResult';
  static const String videoDetail = '/videoDetail';
  static const String studyOne = '/studyOne';
  static const videoPlayer = '/videoPlayer';
  static const videoUrlListPage = '/videoUrlList';
  static const study324 = '/study324';

  static const List<String> notLoginPages = [
    error404,
    login,
    register,
    register,
  ];
}

@TypedGoRoute<TopRoute>(path: RoutePath.home)
class TopRoute extends GoRouteData {
  const TopRoute();

  // @override
  // Widget build(BuildContext context, GoRouterState state) => const TopPage();
  @override
  NoTransitionPage<void> buildPage(BuildContext context, GoRouterState state) =>
      const NoTransitionPage<void>(child: HomePage());
}

@TypedGoRoute<SearchResultRoute>(path: RoutePath.searchResult)
class SearchResultRoute extends GoRouteData {
  final String title;

  const SearchResultRoute(this.title);

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      SearchResultPage(title: title);
}

@TypedGoRoute<SearchRoute>(path: RoutePath.search)
class SearchRoute extends GoRouteData {
  const SearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SearchPage();
}

@TypedGoRoute<VideoDetailRoute>(path: RoutePath.videoDetail)
class VideoDetailRoute extends GoRouteData {
  final ListItemJson $extra;

  const VideoDetailRoute(this.$extra);

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      VideoDetailPage(item: $extra);
}

@TypedGoRoute<StudyOneRoute>(path: RoutePath.studyOne)
class StudyOneRoute extends GoRouteData {
  const StudyOneRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const StudyOne();
}

@TypedGoRoute<VideoPlayerRoute>(path: RoutePath.videoPlayer)
class VideoPlayerRoute extends GoRouteData {
  final List<M3UEntry> $extra;

  const VideoPlayerRoute(this.$extra);

  @override
  Widget build(BuildContext context, GoRouterState state) => VideoKitPage(
        urls: $extra,
      );
}

@TypedGoRoute<VideoUrlListRoute>(path: RoutePath.videoUrlListPage)
class VideoUrlListRoute extends GoRouteData {
  const VideoUrlListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const VideoUrlListPage();
}

@TypedGoRoute<Study324Route>(path: RoutePath.study324)
class Study324Route extends GoRouteData {
  const Study324Route();

  @override
  Widget build(BuildContext context, GoRouterState state) => const Study324();
}
