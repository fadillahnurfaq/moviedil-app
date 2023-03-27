part of 'cast_movie_detail_bloc.dart';

abstract class CastMovieDetailState extends Equatable {
  const CastMovieDetailState();

  @override
  List<Object?> get props => [];
}

class CastMoviesDetailInitialState extends CastMovieDetailState {}

class CastMoviesDetailLoadingState extends CastMovieDetailState {}

class CastMoviesDetailHasDataState extends CastMovieDetailState {
  final CastDetailEntity result;

  const CastMoviesDetailHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class CastMoviesDetailErrorState extends CastMovieDetailState {
  final String message;

  const CastMoviesDetailErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
