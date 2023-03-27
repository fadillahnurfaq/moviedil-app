import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../domain/entities/tv_series_entity.dart';
import '../../../../domain/usecase/tv_series/search_tv_series.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTvSeries _searchTvSeries;

  SearchTvSeriesBloc(this._searchTvSeries)
      : super(SearchTvSeriesInitialState()) {
    on<SearchTvSeriesEvent>((event, emit) async {
      if (event is SearchTvSeriesOnQueryChangedEvent) {
        final query = event.query;

        emit(SearchTvSeriesLoadingState());

        final result = await _searchTvSeries.execute(query);
        result.fold(
          (failure) {
            emit(SearchTvSeriesErrorState(failure.message));
          },
          (data) {
            if (data.isEmpty) {
              emit(SearchTvSeriesEmptyState());
            } else {
              emit(SearchTvSeriesHasDataState(data));
            }
          },
        );
      }
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
