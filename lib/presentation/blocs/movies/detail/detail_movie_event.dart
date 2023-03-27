part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();

  @override
  List<Object?> get props => [];
}

class GetDetailMovieEvent extends DetailMovieEvent {
  final int id;

  const GetDetailMovieEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddWatchlistMovieEvent extends DetailMovieEvent {
  final MovieDetail movieDetail;

  const AddWatchlistMovieEvent(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class RemoveFromWatchlistMovieEvent extends DetailMovieEvent {
  final MovieDetail movieDetail;

  const RemoveFromWatchlistMovieEvent(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class LoadWatchlistStatusMovieEvent extends DetailMovieEvent {
  final int id;

  const LoadWatchlistStatusMovieEvent(this.id);

  @override
  List<Object?> get props => [id];
}
