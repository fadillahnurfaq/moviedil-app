import 'package:ditonton_yuk/domain/entities/cast_entity.dart';
import 'package:equatable/equatable.dart';

class CastModel extends Equatable {
  final bool? adult;
  final int? gender, id, castId, order;
  final double? popularity;
  final String? knownForDepartment,
      name,
      originalName,
      profilePath,
      character,
      creditId;

  const CastModel({
    this.adult,
    this.gender,
    this.id,
    this.castId,
    this.order,
    this.popularity,
    this.character,
    this.creditId,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.profilePath,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) => CastModel(
        adult: json["adult"],
        castId: json["cast_id"],
        gender: json["gender"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        id: json["id"],
        popularity: json["popularity"],
        profilePath: json["profile_path"],
        character: json["character"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "cast_id": castId,
        "gender": gender,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "id": id,
        "popularity": popularity,
        "profile_path": profilePath,
        "character": character,
        "order": order,
      };

  CastEntity toEntity() => CastEntity(
      adult: adult,
      gender: gender,
      id: id,
      castId: castId,
      order: order,
      popularity: popularity,
      character: character,
      creditId: creditId,
      knownForDepartment: knownForDepartment,
      name: name,
      originalName: originalName,
      profilePath: profilePath);

  @override
  List<Object?> get props => [
        adult,
        castId,
        gender,
        knownForDepartment,
        name,
        originalName,
        id,
        popularity,
        profilePath,
        character,
        order,
      ];
}
