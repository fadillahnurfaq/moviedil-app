import 'package:ditonton_yuk/data/datasources/movie_local_data_source.dart';
import 'package:ditonton_yuk/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton_yuk/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton_yuk/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton_yuk/domain/repositories/tv_series_repository.dart';
import 'package:ditonton_yuk/domain/usecase/movies/get_cast_detail_movies.dart';
import 'package:ditonton_yuk/domain/usecase/movies/get_cast_movies.dart';
import 'package:ditonton_yuk/domain/usecase/movies/get_detail_movies.dart';
import 'package:ditonton_yuk/domain/usecase/movies/get_now_playing_movies.dart';
import 'package:ditonton_yuk/domain/usecase/movies/get_watchlist_movies.dart';
import 'package:ditonton_yuk/domain/usecase/movies/get_watchlist_status_movie.dart';
import 'package:ditonton_yuk/domain/usecase/movies/remove_watchlist_movie.dart';
import 'package:ditonton_yuk/domain/usecase/movies/save_watchlist_movie.dart';
import 'package:ditonton_yuk/domain/usecase/tv_series/get_detail_tv_series.dart';
import 'package:ditonton_yuk/domain/usecase/tv_series/get_now_playing_tv_series.dart';
import 'package:ditonton_yuk/domain/usecase/movies/get_popular_movies.dart';
import 'package:ditonton_yuk/domain/usecase/movies/get_recomendation_movie.dart';
import 'package:ditonton_yuk/domain/usecase/movies/get_top_rated_movies.dart';
import 'package:ditonton_yuk/domain/usecase/movies/search_movies.dart';
import 'package:ditonton_yuk/domain/usecase/tv_series/get_popular_tv_series.dart';
import 'package:ditonton_yuk/domain/usecase/tv_series/get_recommentaion_tv_series.dart';
import 'package:ditonton_yuk/domain/usecase/tv_series/get_season_detail.dart';
import 'package:ditonton_yuk/domain/usecase/tv_series/get_top_rated_tv_series.dart';
import 'package:ditonton_yuk/domain/usecase/tv_series/search_tv_series.dart';
import 'package:ditonton_yuk/presentation/blocs/movies/cast/cast_movie_bloc.dart';
import 'package:ditonton_yuk/presentation/blocs/movies/cast_detail/cast_movie_detail_bloc.dart';
import 'package:ditonton_yuk/presentation/blocs/movies/now_playing/now_playing_movies_bloc.dart';
import 'package:ditonton_yuk/presentation/blocs/movies/watchlist/watchlist_movies_bloc.dart';
import 'package:ditonton_yuk/presentation/blocs/tv_series/detail/detail_tv_series_bloc.dart';
import 'package:ditonton_yuk/presentation/blocs/tv_series/popular/popular_tv_series_bloc.dart';
import 'package:ditonton_yuk/presentation/blocs/tv_series/recommendation/recommendation_tv_series_bloc.dart';
import 'package:ditonton_yuk/presentation/blocs/tv_series/search/search_tv_series_bloc.dart';
import 'package:ditonton_yuk/presentation/blocs/tv_series/season_detail/season_detail_bloc.dart';
import 'package:ditonton_yuk/presentation/blocs/tv_series/top_rated/top_rated_tv_series_bloc.dart';
import 'package:ditonton_yuk/presentation/blocs/tv_series/watchlist/watchlist_tv_series_bloc.dart';
import 'package:ditonton_yuk/presentation/blocs/tv_series/watchlist_status/watchlist_status_tv_series_bloc.dart';

import 'package:ditonton_yuk/presentation/cubit/navigationbar_cubit.dart';
import 'package:ditonton_yuk/utils/http_ssl_painning.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/db/database_helper.dart';
import 'data/datasources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/usecase/tv_series/get_watchlist_status_tv_series.dart';
import 'domain/usecase/tv_series/get_watchlist_tv_series.dart';
import 'domain/usecase/tv_series/remove_watchlist_tv_series.dart';
import 'domain/usecase/tv_series/save_watchlist_tv_series.dart';
import 'presentation/blocs/movies/detail/detail_movie_bloc.dart';
import 'presentation/blocs/movies/popular/popular_movies_bloc.dart';
import 'presentation/blocs/movies/search/search_movies_bloc.dart';
import 'presentation/blocs/movies/top_rated/top_rated_movies_bloc.dart';
import 'presentation/blocs/tv_series/now_playing/now_playing_tv_series_bloc.dart';

final locator = GetIt.instance;

void init() {
  // Cubit
  locator.registerFactory(() => NavigationBarCubit());

  // Bloc Movies
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(() => SearchMoviesBloc(locator()));
  locator.registerFactory(() => WatchlistMoviesBloc(locator()));
  locator.registerFactory(() => CastMovieBloc(locator()));
  locator.registerFactory(() => CastMovieDetailBloc(locator()));
  locator.registerFactory(
    () => DetailMovieBloc(
      getDetailMovie: locator(),
      getRecommendationMovies: locator(),
      getWatchListStatusMovie: locator(),
      removeWatchlistMovie: locator(),
      saveWatchlistMovie: locator(),
    ),
  );

  // Bloc Tv Series

  locator.registerFactory(() => NowPlayingTvSeriesBloc(locator()));
  locator.registerFactory(() => PopularTvSeriesBloc(locator()));
  locator.registerFactory(() => TopRatedTvSeriesBloc(locator()));
  locator.registerFactory(() => DetailTvSeriesBloc(locator()));
  locator.registerFactory(() => RecommendationTvSeriesBloc(locator()));
  locator.registerFactory(() => SeasonDetailBloc(locator()));
  locator.registerFactory(() => SearchTvSeriesBloc(locator()));
  locator.registerFactory(
    () => WatchlistStatusTvSeriesBloc(
      getWatchListStatusTvSeries: locator(),
      removeWatchlistTvSeries: locator(),
      saveWatchlistTvSeries: locator(),
    ),
  );
  locator.registerFactory(() => WatchlistTvSeriesBloc(locator()));

  // Usecase movies
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetDetailMovie(locator()));
  locator.registerLazySingleton(() => GetRecommendationMovies(locator()));
  locator.registerLazySingleton(() => GetSearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetCastMovies(locator()));
  locator.registerLazySingleton(() => GetCastDetailMovies(locator()));

  // Usecase tv series

  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetDetailTvSeries(locator()));
  locator.registerLazySingleton(() => GetRecommendationTvSeries(locator()));
  locator.registerLazySingleton(() => GetSeasonDetail(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // Database Helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
