import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/movie_entity.dart';
import '../../repositories/movie_repository.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<MovieEntity>>> execute() {
    return repository.getNowPlaying();
  }
}
