import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/season_detail_entity.dart';
import '../entities/tv_series_entity.dart';
import '../entities/tv_series_detail_entity.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeriesEntity>>> getNowPlaying();
  Future<Either<Failure, List<TvSeriesEntity>>> getPopular();
  Future<Either<Failure, List<TvSeriesEntity>>> getTopRated();
  Future<Either<Failure, TvSeriesDetailEntity>> getDetail(int id);
  Future<Either<Failure, List<TvSeriesEntity>>> getRecommendation(int id);
  Future<Either<Failure, List<TvSeriesEntity>>> search(String query);
  Future<Either<Failure, SeasonDetailEntity>> getSeasonDetail(
    int id,
    int seasonNumber,
  );
  Future<Either<Failure, List<TvSeriesEntity>>> getWatchlist();
  Future<Either<Failure, String>> saveWatchlist(
      TvSeriesDetailEntity tvSeriesDetail);
  Future<Either<Failure, String>> removeWatchlist(
    TvSeriesDetailEntity tvSeriesDetail,
  );
  Future<bool> isAddedToWatchlist(int id);
}
