part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();
  @override
  List<Object?> get props => [];
}

class PopularMoviesInitialState extends PopularMoviesState {}

class PopularMoviesLoadingState extends PopularMoviesState {}

class PopularMoviesHasDataState extends PopularMoviesState {
  final List<MovieEntity> result;

  const PopularMoviesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class PopularMoviesErrorState extends PopularMoviesState {
  final String message;

  const PopularMoviesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
