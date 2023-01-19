part of 'games_list_bloc.dart';

@immutable
abstract class GamesListState extends Equatable{}


class GamesListLoadingState extends GamesListState {
  @override
  List<Object?> get props => [];
}

class GamesListLoadedState extends GamesListState {

  GamesListLoadedState();

  @override
  List<Object?> get props => [];
}

class GamesListErrorState extends GamesListState {
  final String error;

  GamesListErrorState(this.error);

  @override
  List<Object?> get props => [error];
}