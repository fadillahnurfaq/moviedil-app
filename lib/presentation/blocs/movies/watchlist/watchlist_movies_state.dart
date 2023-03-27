part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object?> get props => [];
}

class WatchlistMoviesInitialState extends WatchlistMoviesState {}

class WatchlistMoviesEmptyState extends WatchlistMoviesState {}

class WatchlistMoviesLoadingState extends WatchlistMoviesState {}

class WatchlistMoviesHasDataState extends WatchlistMoviesState {
  final List<MovieEntity> result;

  const WatchlistMoviesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class WatchlistMoviesErrorState extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
