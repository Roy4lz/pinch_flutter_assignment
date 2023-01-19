import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinch_assignment/bloc/games_list/games_list_bloc.dart';
import 'package:flutter_pinch_assignment/domain/database/entities/game_entity.dart';
import 'package:flutter_pinch_assignment/domain/repositories/games_list_repository.dart';
import 'package:flutter_pinch_assignment/presentation/widgets/app_bar.dart';
import 'package:flutter_pinch_assignment/presentation/widgets/game_tile.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/constants.dart';

//ignore: must_be_immutable
class GamesListPage extends StatelessWidget {
  GamesListPage({super.key});

  final List<GameEntity?> _gamesList = [];
  late ScrollController _scrollController;
  final ScrollController _loadingScrollController = ScrollController();
  double scrollOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar("Popular Games"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scrollOffset = 0;
          _scrollController.animateTo(0, duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
        },
        backgroundColor: ThemeColors.defaultButtonColor,
        child: const Icon(Icons.keyboard_arrow_up_rounded),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ThemeColors.backgroundLightColor, ThemeColors.backgroundDarkColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
        child: SafeArea(
          child: BlocProvider(
            create: (context) => GamesListBloc(RepositoryProvider.of<GamesListRepository>(context))
            ..add(LoadGamesListEvent()),
            child: BlocBuilder<GamesListBloc, GamesListState>(
              builder: (context, state) {
                if(state is GamesListLoadingState){
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 40),
                          itemCount: 5,
                          reverse: _gamesList.isNotEmpty && BlocProvider.of<GamesListBloc>(context).isFetching ? true: false,
                          controller: _loadingScrollController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return _gamesList.isNotEmpty && BlocProvider.of<GamesListBloc>(context).isFetching ? GameTile(_gamesList.reversed.take(5).toList()[index]) :
                            Shimmer.fromColors(
                              baseColor: ThemeColors.containerDarkColor,
                              highlightColor: ThemeColors.containerLightColor,
                              child: const GameTile(null)
                            );
                          }
                        ),
                      ),
                      _gamesList.isNotEmpty && BlocProvider.of<GamesListBloc>(context).isFetching ?
                        Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(color: ThemeColors.defaultButtonColor.withOpacity(0.6)),
                        ) : Container()
                    ],
                  );
                } else if(state is GamesListLoadedState || _gamesList.isNotEmpty){
                  _scrollController = ScrollController(initialScrollOffset: !BlocProvider.of<GamesListBloc>(context).isFetching ? 0 :
                    scrollOffset + (RepositoryProvider.of<GamesListRepository>(context).gamesList.isEmpty ? 0 : 80));
                  BlocProvider.of<GamesListBloc>(context).isFetching = false;
                  //Data successfully retrieved
                  _gamesList.addAll(RepositoryProvider.of<GamesListRepository>(context).gamesList);
                  return RefreshIndicator(
                    onRefresh: () {
                      _gamesList.clear();
                      scrollOffset = 0;
                      return _refreshGames(context);
                    },
                    child: ListView.builder(
                      controller: _scrollController..addListener(() {
                        if (_scrollController.offset == _scrollController.position.maxScrollExtent && !BlocProvider.of<GamesListBloc>(context).isFetching) {
                          scrollOffset = _scrollController.offset;
                          BlocProvider.of<GamesListBloc>(context)..isFetching = true..add(LoadGamesListEvent());
                        }
                      }),
                      padding: const EdgeInsets.only(top: 40),
                      itemCount: _gamesList.length,
                      itemBuilder: (BuildContext context, int index)  => GameTile(_gamesList[index]!)
                    ),
                  );
                } else if (state is GamesListErrorState){
                  BlocProvider.of<GamesListBloc>(context).isFetching = false;
                  return const Error();
                } else {
                  return const Error();
                }
              },
            )
          ),
        ),
      ),
    );
  }

  Future<void> _refreshGames(BuildContext context) async {
    BlocProvider.of<GamesListBloc>(context).add(LoadGamesListEvent(refresh: true));
  }
}

class Error extends StatelessWidget {
  const Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.white.withAlpha(70), size: 50),
            const SizedBox(height: 30),
            Text(
              "Something wrong when trying to retrieve content, check your internet connection.",
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              onPressed: (){
                BlocProvider.of<GamesListBloc>(context).add(LoadGamesListEvent());
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
                child: Text("Try again",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
