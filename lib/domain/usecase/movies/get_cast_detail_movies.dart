import 'package:dartz/dartz.dart';
import 'package:ditonton_yuk/domain/entities/cast_detail_entity.dart';

import '../../../utils/failure.dart';
import '../../repositories/movie_repository.dart';

class GetCastDetailMovies {
  final MovieRepository repository;

  GetCastDetailMovies(this.repository);

  Future<Either<Failure, CastDetailEntity>> execute(int id) {
    return repository.getDetailCast(id);
  }
}
