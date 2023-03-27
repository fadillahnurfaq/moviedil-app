import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/tv_series_entity.dart';
import '../../../../domain/usecase/tv_series/get_now_playing_tv_series.dart';

part 'now_playing_tv_series_event.dart';
part 'now_playing_tv_series_state.dart';

class NowPlayingTvSeriesBloc
    extends Bloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState> {
  final GetNowPlayingTvSeries _getNowPlayingTvSeries;

  NowPlayingTvSeriesBloc(this._getNowPlayingTvSeries)
      : super(NowPlayingTvSeriesEmptyState()) {
    on<NowPlayingTvSeriesEvent>((event, emit) async {
      if (event is GetNowPlayingTvSeriesEvent) {
        emit(NowPlayingTvSeriesLoadingState());

        final result = await _getNowPlayingTvSeries.execute();

        result.fold(
          (failure) => emit(NowPlayingTvSeriesErrorState(failure.message)),
          (data) => emit(NowPlayingTvSeriesHasDataState(data)),
        );
      }
    });
  }
}
