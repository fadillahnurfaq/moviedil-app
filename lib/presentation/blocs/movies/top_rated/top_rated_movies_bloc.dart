import 'package:ditonton_yuk/domain/usecase/movies/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/movie_entity.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;
  TopRatedMoviesBloc(this._getTopRatedMovies)
      : super(TopRatedMoviesInitialState()) {
    on<TopRatedMoviesEvent>((event, emit) async {
      if (event is GetTopRatedMoviesEvent) {
        final result = await _getTopRatedMovies.execute();

        result
            .fold((failure) => emit(TopRatedMoviesErrorState(failure.message)),
                (data) {
          if (data.isEmpty) {
            emit(TopRatedMoviesInitialState());
          } else {
            emit(TopRatedMoviesHasDataState(data));
          }
        });
      }
    });
  }
}
