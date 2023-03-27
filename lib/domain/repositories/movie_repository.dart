import 'package:ditonton_yuk/domain/entities/cast_detail_entity.dart';
import 'package:ditonton_yuk/domain/entities/cast_entity.dart';
import 'package:ditonton_yuk/domain/entities/movie_detail.dart';

import '../../utils/failure.dart';
import '../entities/movie_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getNowPlaying();
  Future<Either<Failure, List<MovieEntity>>> getPopular();
  Future<Either<Failure, List<MovieEntity>>> getTopRated();
  Future<Either<Failure, List<CastEntity>>> getCast(int id);
  Future<Either<Failure, CastDetailEntity>> getDetailCast(int id);
  Future<Either<Failure, List<MovieEntity>>> getRecommendation(int id);
  Future<Either<Failure, MovieDetail>> getDetail(int id);
  Future<Either<Failure, List<MovieEntity>>> search(String query);
  Future<Either<Failure, List<MovieEntity>>> getWatchlist();
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);
  Future<bool> isAddedToWatchlist(int id);
}
