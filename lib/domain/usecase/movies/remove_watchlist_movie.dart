import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../entities/movie_detail.dart';
import '../../repositories/movie_repository.dart';

class RemoveWatchlistMovie {
  final MovieRepository repository;

  RemoveWatchlistMovie(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
