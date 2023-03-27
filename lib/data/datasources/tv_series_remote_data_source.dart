import 'dart:convert';

import '../../utils/constants.dart';
import '../../utils/exception.dart';
import '../models/season_detail_response_model.dart';
import '../models/tv_series_detail_response_model.dart';
import '../models/tv_series_model.dart';
import 'package:http/http.dart' as http;

import '../models/tv_series_response_model.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getNowPlaying();
  Future<List<TvSeriesModel>> getPopular();
  Future<List<TvSeriesModel>> getTopRated();
  Future<TvSeriesDetailResponseModel> getDetail(int id);
  Future<List<TvSeriesModel>> getRecommendation(int id);
  Future<SeasonDetailResponseModel> getSeasonDetail(int id, int seasonNumber);
  Future<List<TvSeriesModel>> search(String query);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getNowPlaying() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'));

    if (response.statusCode == 200) {
      return TvSeriesResponseModel.fromJson(json.decode(response.body))
          .tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopular() async {
    final response = await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));

    if (response.statusCode == 200) {
      return TvSeriesResponseModel.fromJson(json.decode(response.body))
          .tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRated() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return TvSeriesResponseModel.fromJson(json.decode(response.body))
          .tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailResponseModel> getDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));

    if (response.statusCode == 200) {
      return TvSeriesDetailResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getRecommendation(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return TvSeriesResponseModel.fromJson(json.decode(response.body))
          .tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeasonDetailResponseModel> getSeasonDetail(
      int id, int seasonNumber) async {
    final response = await client
        .get(Uri.parse('$baseUrl/tv/$id/season/$seasonNumber?$apiKey'));

    if (response.statusCode == 200) {
      return SeasonDetailResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> search(String query) async {
    final response =
        await client.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return TvSeriesResponseModel.fromJson(json.decode(response.body))
          .tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
