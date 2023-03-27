import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/movie_detail.dart';
import '../../repositories/movie_repository.dart';

class GetDetailMovie {
  final MovieRepository repository;

  GetDetailMovie(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getDetail(id);
  }
}
