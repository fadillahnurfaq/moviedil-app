import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/season_detail_entity.dart';
import '../../repositories/tv_series_repository.dart';

class GetSeasonDetail {
  final TvSeriesRepository repository;

  GetSeasonDetail(this.repository);

  Future<Either<Failure, SeasonDetailEntity>> execute(
      int id, int seasonNumber) {
    return repository.getSeasonDetail(id, seasonNumber);
  }
}
