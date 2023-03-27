
import 'package:equatable/equatable.dart';

import '../../domain/entities/season_detail_entity.dart';
import 'episode_model.dart';

class SeasonDetailResponseModel extends Equatable {
  final int id;
  final String? airDate;
  final List<EpisodeModel> episodes;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  const SeasonDetailResponseModel({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodes,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];

  SeasonDetailEntity toEntity() {
    return SeasonDetailEntity(
      id: id,
      airDate: airDate,
      episodes: episodes.map((episode) => episode.toEntity()).toList(),
      name: name,
      overview: overview,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'air_date': airDate,
        'episodes': episodes.map((x) => x.toJson()).toList(),
        'name': name,
        'overview': overview,
        'poster_path': posterPath,
        'season_number': seasonNumber,
      };

  factory SeasonDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      SeasonDetailResponseModel(
        id: json['id'],
        airDate: json['air_date'],
        episodes: List<EpisodeModel>.from(
          json['episodes'].map((x) => EpisodeModel.fromJson(x)),
        ),
        name: json['name'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        seasonNumber: json['season_number'],
      );
}
