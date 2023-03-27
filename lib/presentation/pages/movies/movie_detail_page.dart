import 'package:ditonton_yuk/presentation/blocs/movies/cast/cast_movie_bloc.dart';
import 'package:ditonton_yuk/presentation/widgets/movies/movie_detail_content.dart';
import 'package:ditonton_yuk/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton_yuk/injection.dart' as di;
import '../../../domain/entities/movie_detail.dart';
import '../../blocs/movies/detail/detail_movie_bloc.dart';

class MovieDetailPage extends StatelessWidget {
  final int id;
  const MovieDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<DetailMovieBloc>()
            ..add(GetDetailMovieEvent(id))
            ..add(LoadWatchlistStatusMovieEvent(id)),
        ),
        BlocProvider(
          create: (context) =>
              di.locator<CastMovieBloc>()..add(GetCastMovieEvent(id)),
        ),
      ],
      child: Scaffold(
        body: BlocConsumer<DetailMovieBloc, DetailMovieState>(
          listener: (context, state) {
            final message = state.watchlistMessage;
            if (message == DetailMovieBloc.watchlistAddSuccessMessage ||
                message == DetailMovieBloc.watchlistRemoveSuccessMessage) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(message),
                  );
                },
              );
            }
          },
          listenWhen: (oldState, newState) {
            return oldState.watchlistMessage != newState.watchlistMessage &&
                newState.watchlistMessage != '';
          },
          builder: (context, state) {
            final movieDetailState = state.movieDetailState;
            if (movieDetailState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (movieDetailState == RequestState.loaded) {
              final MovieDetail movieDetail = state.movieDetail!;
              return MovieDetailContent(
                movieDetail: movieDetail,
                isAddedWatchlist: state.isAddedToWatchlist,
              );
            } else if (movieDetailState == RequestState.error) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
