import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/tv_series_entity.dart';
import '../../../../domain/usecase/tv_series/get_popular_tv_series.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries _getPopularTvSeries;

  PopularTvSeriesBloc(this._getPopularTvSeries)
      : super(PopularTvSeriesEmptyState()) {
    on<PopularTvSeriesEvent>((event, emit) async {
      if (event is GetPopularTvSeriesEvent) {
        emit(PopularTvSeriesLoadingState());

        final result = await _getPopularTvSeries.execute();
        result.fold(
          (failure) => emit(PopularTvSeriesErrorState(failure.message)),
          (data) => emit(PopularTvSeriesHasDataState(data)),
        );
      }
    });
  }
}
