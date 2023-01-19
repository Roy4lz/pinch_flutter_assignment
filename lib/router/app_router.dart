import 'package:auto_route/auto_route.dart';
import 'package:flutter_pinch_assignment/presentation/pages/detail_page.dart';
import '../presentation/pages/games_list_page.dart';

//run 'flutter packages pub run build_runner build' after changes are made
//https://pub.dev/packages/auto_route for more information

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    CustomRoute(path: "", page: GamesListPage, initial: true,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: 400),
    CustomRoute(path: "details", page: DetailPage, initial: true,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: 400),
  ],
)

class $AppRouter {}