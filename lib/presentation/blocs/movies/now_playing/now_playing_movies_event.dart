part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetNowPlayingMoviesEvent extends NowPlayingMoviesEvent {
  const GetNowPlayingMoviesEvent();

  @override
  List<Object> get props => [];
}
