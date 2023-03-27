import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/movie_entity.dart';
import '../../repositories/movie_repository.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<MovieEntity>>> execute() {
    return _repository.getWatchlist();
  }
}
