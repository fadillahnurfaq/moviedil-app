import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/tv_series_detail_entity.dart';
import '../../../../domain/usecase/tv_series/get_detail_tv_series.dart';

part 'detail_tv_series_event.dart';
part 'detail_tv_series_state.dart';

class DetailTvSeriesBloc
    extends Bloc<DetailTvSeriesEvent, DetailTvSeriesState> {
  final GetDetailTvSeries _getDetailTvSeries;
  DetailTvSeriesBloc(this._getDetailTvSeries)
      : super(DetailTvSeriesEmptyState()) {
    on<DetailTvSeriesEvent>((event, emit) async {
      if (event is GetDetailTvSeriesEvent) {
        emit(DetailTvSeriesLoadingState());

        final id = event.id;
        final result = await _getDetailTvSeries.execute(id);

        result.fold(
          (failure) => emit(DetailTvSeriesErrorState(failure.message)),
          (data) => emit(DetailTvSeriesHasDataState(data)),
        );
      }
    });
  }
}
