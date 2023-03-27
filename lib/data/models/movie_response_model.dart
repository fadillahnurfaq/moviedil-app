
import 'package:equatable/equatable.dart';

import 'movie_model.dart';

class MovieResponseModel extends Equatable {
  final List<MovieModel> movieList;

  const MovieResponseModel({required this.movieList});

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) =>
      MovieResponseModel(
        movieList: List<MovieModel>.from((json["results"] as List)
            .map((x) => MovieModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(movieList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [movieList];
}
