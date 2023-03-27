part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();

  @override
  List<Object?> get props => [];
}

class WatchlistTvSeriesInitialState extends WatchlistTvSeriesState {}

class WatchlistTvSeriesEmptyState extends WatchlistTvSeriesState {}

class WatchlistTvSeriesLoadingState extends WatchlistTvSeriesState {}

class WatchlistTvSeriesErrorState extends WatchlistTvSeriesState {
  final String message;

  const WatchlistTvSeriesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistTvSeriesHasDataState extends WatchlistTvSeriesState {
  final List<TvSeriesEntity> result;

  const WatchlistTvSeriesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}
