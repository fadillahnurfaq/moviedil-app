import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/tv_series_entity.dart';
import '../../repositories/tv_series_repository.dart';

class GetTopRatedTvSeries {
  final TvSeriesRepository repository;

  GetTopRatedTvSeries(this.repository);

  Future<Either<Failure, List<TvSeriesEntity>>> execute() {
    return repository.getTopRated();
  }
}
