part of 'cast_movie_bloc.dart';

abstract class CastMovieState extends Equatable {
  const CastMovieState();

  @override
  List<Object?> get props => [];
}

class CastMoviesInitialState extends CastMovieState {}

class CastMoviesLoadingState extends CastMovieState {}

class CastMoviesHasDataState extends CastMovieState {
  final List<CastEntity> result;

  const CastMoviesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class CastMoviesErrorState extends CastMovieState {
  final String message;

  const CastMoviesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
