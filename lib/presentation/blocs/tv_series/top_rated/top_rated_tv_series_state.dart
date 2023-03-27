part of 'top_rated_tv_series_bloc.dart';

abstract class TopRatedTvSeriesState extends Equatable {
  const TopRatedTvSeriesState();

  @override
  List<Object?> get props => [];
}

class TopRatedTvSeriesEmptyState extends TopRatedTvSeriesState {}

class TopRatedTvSeriesLoadingState extends TopRatedTvSeriesState {}

class TopRatedTvSeriesErrorState extends TopRatedTvSeriesState {
  final String message;

  const TopRatedTvSeriesErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvSeriesHasDataState extends TopRatedTvSeriesState {
  final List<TvSeriesEntity> result;

  const TopRatedTvSeriesHasDataState(this.result);

  @override
  List<Object> get props => [result];
}
