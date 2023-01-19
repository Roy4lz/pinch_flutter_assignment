import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinch_assignment/domain/repositories/games_list_repository.dart';

part 'games_list_event.dart';
part 'games_list_state.dart';

class GamesListBloc extends Bloc<GamesListEvent, GamesListState> {
  final GamesListRepository repository;

  bool isFetching = false;
  int offset = 0;

  GamesListBloc(this.repository) : super(GamesListLoadingState()) {
    on<LoadGamesListEvent>((event, emit) async {
      emit(GamesListLoadingState());

      if(event.refresh){
        offset = 0;
      }

      try {
        final result = await repository.getGamesList(offset);

        if (result.isNotEmpty) {
          offset += result.length;
          //Return result here
          emit(GamesListLoadedState());
        } else {
          emit(GamesListErrorState("Something went wrong while retrieving games"));
        }
      } catch (e) {
        emit(GamesListErrorState(e.toString()));
      }
    });
  }
}
