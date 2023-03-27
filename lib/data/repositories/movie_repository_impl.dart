import 'dart:io';

import 'package:ditonton_yuk/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton_yuk/domain/entities/cast_detail_entity.dart';
import 'package:ditonton_yuk/domain/entities/cast_entity.dart';
import 'package:ditonton_yuk/domain/entities/movie_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton_yuk/domain/entities/movie_detail.dart';
import 'package:ditonton_yuk/domain/repositories/movie_repository.dart';
import 'package:ditonton_yuk/utils/exception.dart';
import 'package:ditonton_yuk/utils/failure.dart';

import '../datasources/movie_local_data_source.dart';
import '../models/movie_table_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<MovieEntity>>> getNowPlaying() async {
    try {
      final result = await remoteDataSource.getNowPlaying();
      return right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(""));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getPopular() async {
    try {
      final result = await remoteDataSource.getPopular();
      return right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(""));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getTopRated() async {
    try {
      final result = await remoteDataSource.getTopRated();
      return right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(""));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getDetail(int id) async {
    try {
      final result = await remoteDataSource.getDetail(id);
      return right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(""));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getRecommendation(int id) async {
    try {
      final result = await remoteDataSource.getRecommendation(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> search(String query) async {
    try {
      final result = await remoteDataSource.search(query);

      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie) async {
    try {
      final result = await localDataSource
          .insertWatchList(MovieTableModel.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie) async {
    try {
      final result = await localDataSource
          .removeWatchList(MovieTableModel.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getWatchlistById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getWatchlist() async {
    final result = await localDataSource.getWatchlist();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<CastEntity>>> getCast(int id) async {
    try {
      final result = await remoteDataSource.getCast(id);
      return right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, CastDetailEntity>> getDetailCast(int id) async {
    try {
      final result = await remoteDataSource.getDetailCast(id);
      return right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }
}
