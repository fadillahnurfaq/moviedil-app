import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/season_detail_entity.dart';
import '../../../../domain/usecase/tv_series/get_season_detail.dart';

part 'season_detail_event.dart';
part 'season_detail_state.dart';

class SeasonDetailBloc extends Bloc<SeasonDetailEvent, SeasonDetailState> {
  final GetSeasonDetail _getSeasonDetail;

  SeasonDetailBloc(this._getSeasonDetail) : super(SeasonDetailEmptyState()) {
    on<SeasonDetailEvent>((event, emit) async {
      if (event is GetSeasonDetailEvent) {
        emit(SeasonDetailLoadingState());

        final result = await _getSeasonDetail.execute(
          event.id,
          event.seasonNumber,
        );

        result.fold(
          (failure) => emit(SeasonDetailErrorState(failure.message)),
          (data) => emit(SeasonDetailHasDataState(data)),
        );
      }
    });
  }
}
