import 'dart:convert';

import 'package:ditonton_yuk/data/models/cast_detail_model.dart';
import 'package:ditonton_yuk/data/models/cast_model.dart';
import 'package:ditonton_yuk/data/models/cast_response_model.dart';
import 'package:ditonton_yuk/data/models/movie_response_model.dart';
import 'package:ditonton_yuk/utils/constants.dart';
import 'package:ditonton_yuk/utils/exception.dart';
import 'package:http/http.dart' as http;

import '../models/movie_detail_response_model.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlaying();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getTopRated();
  Future<List<CastModel>> getCast(int id);
  Future<CastDetailModel> getDetailCast(int id);
  Future<List<MovieModel>> getRecommendation(int id);
  Future<List<MovieModel>> search(String query);
  Future<MovieDetailResponseModel> getDetail(int id);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlaying() async {
    final response =
        await client.get(Uri.parse("$baseUrl/movie/now_playing?$apiKey"));
    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(jsonDecode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    final response =
        await client.get(Uri.parse("$baseUrl/movie/popular?$apiKey"));
    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(jsonDecode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRated() async {
    final response =
        await client.get(Uri.parse("$baseUrl/movie/top_rated?$apiKey"));
    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(jsonDecode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponseModel> getDetail(int id) async {
    final response = await client.get(Uri.parse("$baseUrl/movie/$id?$apiKey"));
    if (response.statusCode == 200) {
      return MovieDetailResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getRecommendation(int id) async {
    final response = await client
        .get(Uri.parse('$baseUrl/movie/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> search(String query) async {
    final response = await client
        .get(Uri.parse('$baseUrl/search/movie?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return MovieResponseModel.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CastModel>> getCast(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/$id/credits?$apiKey'));
    if (response.statusCode == 200) {
      return CastResponseModel.fromJson(jsonDecode(response.body)).castList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CastDetailModel> getDetailCast(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/person/$id?$apiKey'));
    if (response.statusCode == 200) {
      return CastDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
