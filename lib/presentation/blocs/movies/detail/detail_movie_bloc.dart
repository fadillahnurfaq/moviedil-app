import 'package:ditonton_yuk/domain/usecase/movies/get_detail_movies.dart';
import 'package:ditonton_yuk/domain/usecase/movies/get_recomendation_movie.dart';
import 'package:ditonton_yuk/domain/usecase/movies/get_watchlist_status_movie.dart';
import 'package:ditonton_yuk/domain/usecase/movies/remove_watchlist_movie.dart';
import 'package:ditonton_yuk/domain/usecase/movies/save_watchlist_movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/movie_detail.dart';
import '../../../../domain/entities/movie_entity.dart';
import '../../../../utils/state_enum.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetDetailMovie getDetailMovie;
  final GetRecommendationMovies getRecommendationMovies;
  final SaveWatchlistMovie saveWatchlistMovie;
  final RemoveWatchlistMovie removeWatchlistMovie;
  final GetWatchListStatusMovie getWatchListStatusMovie;

  DetailMovieBloc({
    required this.getDetailMovie,
    required this.getRecommendationMovies,
    required this.getWatchListStatusMovie,
    required this.removeWatchlistMovie,
    required this.saveWatchlistMovie,
  }) : super(DetailMovieState.initial()) {
    on<DetailMovieEvent>((event, emit) async {
      if (event is GetDetailMovieEvent) {
        emit(state.copyWith(movieDetailState: RequestState.loading));
        final id = event.id;

        final detailMovieResult = await getDetailMovie.execute(id);

        final recommendationMoviesResult =
            await getRecommendationMovies.execute(id);

        detailMovieResult.fold(
            (failure) => emit(state.copyWith(
                  movieDetailState: RequestState.error,
                  message: failure.message,
                )), (movieDetail) {
          emit(
            state.copyWith(
              movieRecommendationsState: RequestState.loading,
              movieDetailState: RequestState.loaded,
              movieDetail: movieDetail,
              watchlistMessage: '',
            ),
          );

          recommendationMoviesResult.fold(
              (failure) => emit(
                    state.copyWith(
                      movieRecommendationsState: RequestState.error,
                      message: failure.message,
                    ),
                  ), (movieRecommendations) {
            if (movieRecommendations.isEmpty) {
              emit(
                state.copyWith(
                  movieRecommendationsState: RequestState.empty,
                ),
              );
            } else {
              emit(
                state.copyWith(
                  movieRecommendationsState: RequestState.loaded,
                  movieRecommendations: movieRecommendations,
                ),
              );
            }
          });
        });
      }

      if (event is AddWatchlistMovieEvent) {
        final movieDetail = event.movieDetail;
        final result = await saveWatchlistMovie.execute(movieDetail);

        result.fold(
          (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
          (successMessage) =>
              emit(state.copyWith(watchlistMessage: successMessage)),
        );

        add(LoadWatchlistStatusMovieEvent(movieDetail.id));
      }

      if (event is RemoveFromWatchlistMovieEvent) {
        final movieDetail = event.movieDetail;
        final result = await removeWatchlistMovie.execute(movieDetail);

        result.fold(
          (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
          (successMessage) =>
              emit(state.copyWith(watchlistMessage: successMessage)),
        );

        add(LoadWatchlistStatusMovieEvent(movieDetail.id));
      }

      if (event is LoadWatchlistStatusMovieEvent) {
        final status = await getWatchListStatusMovie.execute(event.id);
        emit(state.copyWith(isAddedToWatchlist: status));
      }
    });
  }
}
