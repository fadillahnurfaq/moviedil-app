part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetWatchlistMoviesEvent extends WatchlistMoviesEvent {
  const GetWatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}
