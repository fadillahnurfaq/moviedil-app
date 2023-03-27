part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesEvent extends Equatable {
  const SearchTvSeriesEvent();

  @override
  List<Object?> get props => [];
}

class SearchTvSeriesOnQueryChangedEvent extends SearchTvSeriesEvent {
  final String query;

  const SearchTvSeriesOnQueryChangedEvent(this.query);

  @override
  List<Object?> get props => [query];
}
