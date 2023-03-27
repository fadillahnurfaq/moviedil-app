import 'package:ditonton_yuk/domain/entities/cast_detail_entity.dart';
import 'package:ditonton_yuk/domain/usecase/movies/get_cast_detail_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cast_movie_detail_event.dart';
part 'cast_movie_detail_state.dart';

class CastMovieDetailBloc
    extends Bloc<CastMovieDetailEvent, CastMovieDetailState> {
  final GetCastDetailMovies _getCastDetailMovies;

  CastMovieDetailBloc(this._getCastDetailMovies)
      : super(CastMoviesDetailInitialState()) {
    on<CastMovieDetailEvent>((event, emit) async {
      if (event is GetCastDetailMovieEvent) {
        emit(CastMoviesDetailLoadingState());
        final result = await _getCastDetailMovies.execute(event.id);

        result.fold(
            (failure) => emit(CastMoviesDetailErrorState(failure.message)),
            (data) {
          emit(CastMoviesDetailHasDataState(data));
        });
      }
    });
  }
}
