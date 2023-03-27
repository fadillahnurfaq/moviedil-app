part of 'search_movies_bloc.dart';

abstract class SearchMoviesState extends Equatable {
  const SearchMoviesState();

  @override
  List<Object> get props => [];
}

class SearchMoviesInitialState extends SearchMoviesState {}

class SearchMoviesEmptyState extends SearchMoviesState {}

class SearchMoviesLoadingState extends SearchMoviesState {}

class SearchMoviesErrorState extends SearchMoviesState {
  final String message;

  const SearchMoviesErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMoviesHasDataState extends SearchMoviesState {
  final List<MovieEntity> result;

  const SearchMoviesHasDataState(this.result);
  @override
  List<Object> get props => [result];
}
