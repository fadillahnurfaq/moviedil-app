import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/tv_series_entity.dart';
import '../../../../domain/usecase/tv_series/get_watchlist_tv_series.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries _getWatchlistTvSeries;

  WatchlistTvSeriesBloc(this._getWatchlistTvSeries)
      : super(WatchlistTvSeriesInitialState()) {
    on<WatchlistTvSeriesEvent>((event, emit) async {
      if (event is GetWatchlistTvSeriesEvent) {
        emit(WatchlistTvSeriesLoadingState());

        final result = await _getWatchlistTvSeries.execute();

        result.fold(
          (failure) => emit(WatchlistTvSeriesErrorState(failure.message)),
          (data) {
            if (data.isEmpty) {
              emit(WatchlistTvSeriesEmptyState());
            } else {
              emit(WatchlistTvSeriesHasDataState(data));
            }
          },
        );
      }
    });
  }
}
