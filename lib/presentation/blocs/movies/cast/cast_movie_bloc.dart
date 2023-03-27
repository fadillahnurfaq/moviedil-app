import 'package:ditonton_yuk/domain/entities/cast_entity.dart';
import 'package:ditonton_yuk/domain/usecase/movies/get_cast_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cast_movie_event.dart';
part 'cast_movie_state.dart';

class CastMovieBloc extends Bloc<CastMovieEvent, CastMovieState> {
  final GetCastMovies _getCastMovies;

  CastMovieBloc(this._getCastMovies) : super(CastMoviesInitialState()) {
    on<CastMovieEvent>((event, emit) async {
      if (event is GetCastMovieEvent) {
        emit(CastMoviesLoadingState());
        final result = await _getCastMovies.execute(event.id);

        result.fold((failure) => emit(CastMoviesErrorState(failure.message)),
            (data) {
          if (data.isEmpty) {
            emit(CastMoviesInitialState());
          } else {
            emit(CastMoviesHasDataState(data));
          }
        });
      }
    });
  }
}
