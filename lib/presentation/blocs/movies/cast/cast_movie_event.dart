part of 'cast_movie_bloc.dart';

abstract class CastMovieEvent extends Equatable {
  const CastMovieEvent();

  @override
  List<Object?> get props => [];
}

class GetCastMovieEvent extends CastMovieEvent {
  final int id;

  const GetCastMovieEvent(this.id);

  @override
  List<Object?> get props => [id];
}
