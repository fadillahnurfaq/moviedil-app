import 'package:ditonton_yuk/domain/entities/cast_detail_entity.dart';
import 'package:equatable/equatable.dart';

class CastDetailModel extends Equatable {
  final int? id, gender;
  final String? biography, birthday, name, placeOfBirth, profilePath;

  const CastDetailModel({
    this.id,
    this.biography,
    this.birthday,
    this.gender,
    this.name,
    this.placeOfBirth,
    this.profilePath,
  });

  factory CastDetailModel.fromJson(Map<String, dynamic> json) =>
      CastDetailModel(
        id: json["id"],
        gender: json["gender"],
        biography: json["biography"],
        birthday: json["birthday"],
        name: json["name"],
        placeOfBirth: json["place_of_birth"],
        profilePath: json["profile_path"],
      );

  CastDetailEntity toEntity() => CastDetailEntity(
        id: id,
        biography: biography,
        birthday: birthday,
        gender: gender,
        name: name,
        placeOfBirth: placeOfBirth,
        profilePath: profilePath,
      );

  @override
  List<Object?> get props => [
        id,
        gender,
        biography,
        birthday,
        name,
        placeOfBirth,
        profilePath,
      ];
}
