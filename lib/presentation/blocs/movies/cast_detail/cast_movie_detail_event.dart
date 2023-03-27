part of 'cast_movie_detail_bloc.dart';

abstract class CastMovieDetailEvent extends Equatable {
  const CastMovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class GetCastDetailMovieEvent extends CastMovieDetailEvent {
  final int id;

  const GetCastDetailMovieEvent(this.id);

  @override
  List<Object?> get props => [id];
}
