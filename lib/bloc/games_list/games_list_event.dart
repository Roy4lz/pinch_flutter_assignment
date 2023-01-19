part of 'games_list_bloc.dart';

@immutable
abstract class GamesListEvent extends Equatable {}

class LoadGamesListEvent extends GamesListEvent {
  final bool refresh;

  @override
  List<Object> get props => [];

  LoadGamesListEvent({this.refresh = false});
}