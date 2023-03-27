part of 'popular_tv_series_bloc.dart';

abstract class PopularTvSeriesState extends Equatable {
  const PopularTvSeriesState();

  @override
  List<Object?> get props => [];
}

class PopularTvSeriesEmptyState extends PopularTvSeriesState {}

class PopularTvSeriesLoadingState extends PopularTvSeriesState {}

class PopularTvSeriesErrorState extends PopularTvSeriesState {
  final String message;

  const PopularTvSeriesErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvSeriesHasDataState extends PopularTvSeriesState {
  final List<TvSeriesEntity> result;

  const PopularTvSeriesHasDataState(this.result);

  @override
  List<Object> get props => [result];
}
