import 'package:equatable/equatable.dart';

class CastEntity extends Equatable {
  final bool? adult;
  final int? gender, id, castId, order;
  final double? popularity;
  final String? knownForDepartment,
      name,
      originalName,
      profilePath,
      character,
      creditId;

  const CastEntity({
    required this.adult,
    required this.gender,
    required this.id,
    required this.castId,
    required this.order,
    required this.popularity,
    required this.character,
    required this.creditId,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.profilePath,
  });

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
