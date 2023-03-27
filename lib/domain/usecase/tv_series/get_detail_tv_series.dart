import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/tv_series_detail_entity.dart';
import '../../repositories/tv_series_repository.dart';

class GetDetailTvSeries {
  final TvSeriesRepository repository;

  GetDetailTvSeries(this.repository);

  Future<Either<Failure, TvSeriesDetailEntity>> execute(int id) {
    return repository.getDetail(id);
  }
}
