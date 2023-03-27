part of 'recommendation_tv_series_bloc.dart';

abstract class RecommendationTvSeriesState extends Equatable {
  const RecommendationTvSeriesState();

  @override
  List<Object?> get props => [];
}

class RecommendationTvSeriesEmptyState extends RecommendationTvSeriesState {}

class RecommendationTvSeriesLoadingState extends RecommendationTvSeriesState {}

class RecommendationTvSeriesErrorState extends RecommendationTvSeriesState {
  final String message;

  const RecommendationTvSeriesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class RecommendationTvSeriesHasDataState extends RecommendationTvSeriesState {
  final List<TvSeriesEntity> result;

  const RecommendationTvSeriesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}
