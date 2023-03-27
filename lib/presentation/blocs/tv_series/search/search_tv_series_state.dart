part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesState extends Equatable {
  const SearchTvSeriesState();

  @override
  List<Object?> get props => [];
}

class SearchTvSeriesInitialState extends SearchTvSeriesState {}

class SearchTvSeriesEmptyState extends SearchTvSeriesState {}

class SearchTvSeriesLoadingState extends SearchTvSeriesState {}

class SearchTvSeriesErrorState extends SearchTvSeriesState {
  final String message;

  const SearchTvSeriesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchTvSeriesHasDataState extends SearchTvSeriesState {
  final List<TvSeriesEntity> result;

  const SearchTvSeriesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}
