import 'package:dartz/dartz.dart';
import 'package:ditonton_yuk/domain/entities/cast_entity.dart';

import '../../../utils/failure.dart';
import '../../repositories/movie_repository.dart';

class GetCastMovies {
  final MovieRepository repository;

  GetCastMovies(this.repository);

  Future<Either<Failure, List<CastEntity>>> execute(int id) {
    return repository.getCast(id);
  }
}
