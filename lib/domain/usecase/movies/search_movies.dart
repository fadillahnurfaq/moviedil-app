import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/movie_entity.dart';
import '../../repositories/movie_repository.dart';

class GetSearchMovies {
  final MovieRepository repository;

  GetSearchMovies(this.repository);

  Future<Either<Failure, List<MovieEntity>>> execute(String query) {
    return repository.search(query);
  }
}
