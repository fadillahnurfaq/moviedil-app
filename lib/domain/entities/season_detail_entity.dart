import 'package:equatable/equatable.dart';

import 'episode_entity.dart';

class SeasonDetailEntity extends Equatable {
  final int id;
  final String? airDate;
  final List<EpisodeEntity> episodes;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  const SeasonDetailEntity({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props {
    return [
      id,
      airDate,
      episodes,
      name,
      overview,
      posterPath,
      seasonNumber,
    ];
  }
}
