// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/foundation.dart' as _i5;
import 'package:flutter/material.dart' as _i4;

import '../domain/database/entities/game_entity.dart' as _i6;
import '../presentation/pages/detail_page.dart' as _i2;
import '../presentation/pages/games_list_page.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    GamesListRoute.name: (routeData) {
      final args = routeData.argsAs<GamesListRouteArgs>(
          orElse: () => const GamesListRouteArgs());
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.GamesListPage(key: args.key),
        transitionsBuilder: _i3.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 400,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DetailRoute.name: (routeData) {
      final args = routeData.argsAs<DetailRouteArgs>();
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: _i2.DetailPage(
          args.game,
          key: args.key,
        ),
        transitionsBuilder: _i3.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 400,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '',
          fullMatch: true,
        ),
        _i3.RouteConfig(
          GamesListRoute.name,
          path: '',
        ),
        _i3.RouteConfig(
          DetailRoute.name,
          path: 'details',
        ),
      ];
}

/// generated route for
/// [_i1.GamesListPage]
class GamesListRoute extends _i3.PageRouteInfo<GamesListRouteArgs> {
  GamesListRoute({_i5.Key? key})
      : super(
          GamesListRoute.name,
          path: '',
          args: GamesListRouteArgs(key: key),
        );

  static const String name = 'GamesListRoute';
}

class GamesListRouteArgs {
  const GamesListRouteArgs({this.key});

  final _i5.Key? key;

  @override
  String toString() {
    return 'GamesListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.DetailPage]
class DetailRoute extends _i3.PageRouteInfo<DetailRouteArgs> {
  DetailRoute({
    required _i6.GameEntity game,
    _i5.Key? key,
  }) : super(
          DetailRoute.name,
          path: 'details',
          args: DetailRouteArgs(
            game: game,
            key: key,
          ),
        );

  static const String name = 'DetailRoute';
}

class DetailRouteArgs {
  const DetailRouteArgs({
    required this.game,
    this.key,
  });

  final _i6.GameEntity game;

  final _i5.Key? key;

  @override
  String toString() {
    return 'DetailRouteArgs{game: $game, key: $key}';
  }
}
