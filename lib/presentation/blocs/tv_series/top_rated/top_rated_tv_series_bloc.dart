import 'package:ditonton_yuk/domain/usecase/tv_series/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/tv_series_entity.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries _getPopularTvSeries;

  TopRatedTvSeriesBloc(this._getPopularTvSeries)
      : super(TopRatedTvSeriesEmptyState()) {
    on<TopRatedTvSeriesEvent>((event, emit) async {
      if (event is GetTopRatedTvSeriesEvent) {
        emit(TopRatedTvSeriesLoadingState());

        final result = await _getPopularTvSeries.execute();

        result.fold(
          (failure) => emit(TopRatedTvSeriesErrorState(failure.message)),
          (data) => emit(TopRatedTvSeriesHasDataState(data)),
        );
      }
    });
  }
}
