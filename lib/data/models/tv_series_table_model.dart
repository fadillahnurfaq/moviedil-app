import 'package:ditonton_yuk/domain/entities/tv_series_detail_entity.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_series_entity.dart';

class TvSeriesTableModel extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  const TvSeriesTableModel({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TvSeriesTableModel.fromEntity(TvSeriesDetailEntity tvSeries) =>
      TvSeriesTableModel(
        id: tvSeries.id,
        name: tvSeries.name,
        posterPath: tvSeries.posterPath,
        overview: tvSeries.overview,
      );

  factory TvSeriesTableModel.fromMap(Map<String, dynamic> map) =>
      TvSeriesTableModel(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  TvSeriesEntity toEntity() => TvSeriesEntity.watchlist(
        id: id,
        name: name,
        overview: overview,
        posterPath: posterPath,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        overview,
      ];
}
