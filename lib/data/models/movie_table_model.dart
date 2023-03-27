import 'package:equatable/equatable.dart';

import '../../domain/entities/movie_entity.dart';
import '../../domain/entities/movie_detail.dart';

class MovieTableModel extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  const MovieTableModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory MovieTableModel.fromEntity(MovieDetail movie) => MovieTableModel(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory MovieTableModel.fromMap(Map<String, dynamic> map) => MovieTableModel(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  MovieEntity toEntity() => MovieEntity.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
