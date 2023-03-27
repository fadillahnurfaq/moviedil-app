import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/movie_entity.dart';
import '../../../../domain/usecase/movies/get_now_playing_movies.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies)
      : super(NowPlayingMoviesInitialState()) {
    on<NowPlayingMoviesEvent>((event, emit) async {
      if (event is GetNowPlayingMoviesEvent) {
        final result = await _getNowPlayingMovies.execute();

        result.fold(
            (failure) => emit(NowPlayingMoviesErrorState(failure.message)),
            (data) {
          if (data.isEmpty) {
            emit(NowPlayingMoviesInitialState());
          } else {
            emit(NowPlayingMoviesHasDataState(data));
          }
        });
      }
    });
  }
}
