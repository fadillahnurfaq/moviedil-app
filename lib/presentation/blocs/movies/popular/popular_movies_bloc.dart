import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/movie_entity.dart';
import '../../../../domain/usecase/movies/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;
  PopularMoviesBloc(this._getPopularMovies)
      : super(PopularMoviesInitialState()) {
    on<PopularMoviesEvent>((event, emit) async {
      if (event is GetPopularMoviesEvent) {
        emit(PopularMoviesLoadingState());

        final result = await _getPopularMovies.execute();
        result.fold((failure) => emit(PopularMoviesErrorState(failure.message)),
            (data) {
          if (data.isEmpty) {
            emit(PopularMoviesInitialState());
          } else {
            emit(PopularMoviesHasDataState(data));
          }
        });

        // results.fold
      }
    });
  }
}
