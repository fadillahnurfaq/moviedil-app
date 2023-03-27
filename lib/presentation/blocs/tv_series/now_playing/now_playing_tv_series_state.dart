part of 'now_playing_tv_series_bloc.dart';

abstract class NowPlayingTvSeriesState extends Equatable {
  const NowPlayingTvSeriesState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvSeriesEmptyState extends NowPlayingTvSeriesState {}

class NowPlayingTvSeriesLoadingState extends NowPlayingTvSeriesState {}

class NowPlayingTvSeriesErrorState extends NowPlayingTvSeriesState {
  final String message;

  const NowPlayingTvSeriesErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvSeriesHasDataState extends NowPlayingTvSeriesState {
  final List<TvSeriesEntity> result;

  const NowPlayingTvSeriesHasDataState(this.result);

  @override
  List<Object> get props => [result];
}
