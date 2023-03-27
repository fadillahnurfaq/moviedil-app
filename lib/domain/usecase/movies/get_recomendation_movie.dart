import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/movie_entity.dart';
import '../../repositories/movie_repository.dart';

class GetRecommendationMovies {
  final MovieRepository repository;

  GetRecommendationMovies(this.repository);

  Future<Either<Failure, List<MovieEntity>>> execute(id) {
    return repository.getRecommendation(id);
  }
}
