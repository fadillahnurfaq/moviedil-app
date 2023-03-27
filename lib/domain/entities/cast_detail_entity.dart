import 'package:equatable/equatable.dart';

class CastDetailEntity extends Equatable {
  final int? id, gender;
  final String? biography, birthday, name, placeOfBirth, profilePath;

  const CastDetailEntity({
    required this.id,
    required this.biography,
    required this.birthday,
    required this.gender,
    required this.name,
    required this.placeOfBirth,
    required this.profilePath,
  });

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
