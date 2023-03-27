import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/tv_series_detail_entity.dart';

import '../../../../domain/usecase/tv_series/get_watchlist_status_tv_series.dart';
import '../../../../domain/usecase/tv_series/remove_watchlist_tv_series.dart';
import '../../../../domain/usecase/tv_series/save_watchlist_tv_series.dart';

part 'watchlist_status_tv_series_event.dart';
part 'watchlist_status_tv_series_state.dart';

class WatchlistStatusTvSeriesBloc
    extends Bloc<WatchlistStatusTvSeriesEvent, WatchlistStatusTvSeriesState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListStatusTvSeries getWatchListStatusTvSeries;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;

  WatchlistStatusTvSeriesBloc({
    required this.getWatchListStatusTvSeries,
    required this.removeWatchlistTvSeries,
    required this.saveWatchlistTvSeries,
  }) : super(const WatchlistStatusTvSeriesState(
            isAddedToWatchlist: false, message: "")) {
    on<WatchlistStatusTvSeriesEvent>((event, emit) async {
      if (event is AddWatchlistTvSeriesEvent) {
        final tvSeriesDetail = event.tvSeriesDetail;
        final id = tvSeriesDetail.id;

        final result = await saveWatchlistTvSeries.execute(tvSeriesDetail);
        final status = await getWatchListStatusTvSeries.execute(id);

        result.fold(
          (failure) {
            emit(WatchlistStatusTvSeriesState(
              isAddedToWatchlist: status,
              message: failure.message,
            ));
          },
          (successMessage) {
            emit(WatchlistStatusTvSeriesState(
              isAddedToWatchlist: status,
              message: successMessage,
            ));
          },
        );
      }

      if (event is RemoveFromWatchlistTvSeriesEvent) {
        final tvSeriesDetail = event.tvSeriesDetail;
        final id = tvSeriesDetail.id;

        final result = await removeWatchlistTvSeries.execute(tvSeriesDetail);
        final status = await getWatchListStatusTvSeries.execute(id);

        result.fold(
          (failure) {
            emit(WatchlistStatusTvSeriesState(
              isAddedToWatchlist: status,
              message: failure.message,
            ));
          },
          (successMessage) {
            emit(WatchlistStatusTvSeriesState(
              isAddedToWatchlist: status,
              message: successMessage,
            ));
          },
        );
      }

      if (event is LoadWatchlistStatusTvSeriesEvent) {
        final id = event.id;
        final status = await getWatchListStatusTvSeries.execute(id);

        emit(WatchlistStatusTvSeriesState(
          isAddedToWatchlist: status,
          message: '',
        ));
      }
    });
  }
}
