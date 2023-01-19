import 'package:flutter/material.dart';
import 'package:flutter_pinch_assignment/presentation/custom_theme_data.dart';
import 'package:flutter_pinch_assignment/providers/games_list_provider.dart';
import 'package:flutter_pinch_assignment/services/game_db_service.dart';
import 'package:get_it/get_it.dart';
import 'domain/repositories/games_list_repository.dart';
import 'router/app_router.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  final GetIt injector = GetIt.I;
  injector.registerSingletonAsync<GameDbService>(() async {
    var gameDbService = GameDbService();
    return gameDbService.init();
  }, signalsReady: false);

  WidgetsFlutterBinding.ensureInitialized();
  await injector.allReady();
  runApp(GameApp());
}

class GameApp extends StatelessWidget {
  GameApp({super.key});

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => GamesListRepository(GamesListProvider()),
      child: MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        title: 'Pinch Flutter Assignment',
        theme: CustomThemeData.getTheme(),
      ),
    );
  }
}
