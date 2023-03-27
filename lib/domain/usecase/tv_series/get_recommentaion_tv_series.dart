import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/tv_series_entity.dart';
import '../../repositories/tv_series_repository.dart';

class GetRecommendationTvSeries {
  final TvSeriesRepository repository;

  GetRecommendationTvSeries(this.repository);

  Future<Either<Failure, List<TvSeriesEntity>>> execute(int id) {
    return repository.getRecommendation(id);
  }
}
