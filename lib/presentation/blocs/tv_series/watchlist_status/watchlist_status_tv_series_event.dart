part of 'watchlist_status_tv_series_bloc.dart';

abstract class WatchlistStatusTvSeriesEvent extends Equatable {
  const WatchlistStatusTvSeriesEvent();

  @override
  List<Object?> get props => [];
}

class AddWatchlistTvSeriesEvent extends WatchlistStatusTvSeriesEvent {
  final TvSeriesDetailEntity tvSeriesDetail;

  const AddWatchlistTvSeriesEvent(this.tvSeriesDetail);

  @override
  List<Object?> get props => [tvSeriesDetail];
}

class RemoveFromWatchlistTvSeriesEvent extends WatchlistStatusTvSeriesEvent {
  final TvSeriesDetailEntity tvSeriesDetail;

  const RemoveFromWatchlistTvSeriesEvent(this.tvSeriesDetail);

  @override
  List<Object?> get props => [tvSeriesDetail];
}

class LoadWatchlistStatusTvSeriesEvent extends WatchlistStatusTvSeriesEvent {
  final int id;

  const LoadWatchlistStatusTvSeriesEvent(this.id);

  @override
  List<Object?> get props => [id];
}
