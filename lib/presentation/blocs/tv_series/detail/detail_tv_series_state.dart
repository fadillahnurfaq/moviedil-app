part of 'detail_tv_series_bloc.dart';

abstract class DetailTvSeriesState extends Equatable {
  const DetailTvSeriesState();

  @override
  List<Object?> get props => [];
}

class DetailTvSeriesEmptyState extends DetailTvSeriesState {}

class DetailTvSeriesLoadingState extends DetailTvSeriesState {}

class DetailTvSeriesErrorState extends DetailTvSeriesState {
  final String message;

  const DetailTvSeriesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class DetailTvSeriesHasDataState extends DetailTvSeriesState {
  final TvSeriesDetailEntity result;

  const DetailTvSeriesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}
