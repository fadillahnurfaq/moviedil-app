import 'package:ditonton_yuk/domain/usecase/movies/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/movie_entity.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMoviesBloc(this._getWatchlistMovies)
      : super(WatchlistMoviesInitialState()) {
    on<WatchlistMoviesEvent>((event, emit) async {
      if (event is GetWatchlistMoviesEvent) {
        emit(WatchlistMoviesLoadingState());

        final result = await _getWatchlistMovies.execute();

        result.fold(
          (failure) => emit(WatchlistMoviesErrorState(failure.message)),
          (data) {
            if (data.isEmpty) {
              emit(WatchlistMoviesEmptyState());
            } else {
              emit(WatchlistMoviesHasDataState(data));
            }
          },
        );
      }
    });
  }
}
