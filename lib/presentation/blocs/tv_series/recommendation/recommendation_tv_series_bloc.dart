import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/tv_series_entity.dart';
import '../../../../domain/usecase/tv_series/get_recommentaion_tv_series.dart';

part 'recommendation_tv_series_event.dart';
part 'recommendation_tv_series_state.dart';

class RecommendationTvSeriesBloc
    extends Bloc<RecommendationTvSeriesEvent, RecommendationTvSeriesState> {
  final GetRecommendationTvSeries _getRecommendationTvSeries;

  RecommendationTvSeriesBloc(this._getRecommendationTvSeries)
      : super(RecommendationTvSeriesEmptyState()) {
    on<RecommendationTvSeriesEvent>((event, emit) async {
      if (event is GetRecommendationTvSeriesEvent) {
        emit(RecommendationTvSeriesLoadingState());

        final id = event.id;
        final result = await _getRecommendationTvSeries.execute(id);

        result.fold(
          (failure) => emit(RecommendationTvSeriesErrorState(failure.message)),
          (data) {
            if (data.isEmpty) {
              emit(RecommendationTvSeriesEmptyState());
            } else {
              emit(RecommendationTvSeriesHasDataState(data));
            }
          },
        );
      }
    });
  }
}
