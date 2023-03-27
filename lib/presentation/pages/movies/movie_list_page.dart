import 'package:ditonton_yuk/presentation/pages/movies/popular_movies_page.dart';
import 'package:ditonton_yuk/presentation/pages/movies/search_movie_page.dart';
import 'package:ditonton_yuk/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:ditonton_yuk/presentation/widgets/movies/movie_card.dart';
import 'package:ditonton_yuk/presentation/widgets/sub_heading.dart';
import 'package:ditonton_yuk/state_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton_yuk/injection.dart' as di;
import '../../../utils/constants.dart';
import '../../blocs/movies/now_playing/now_playing_movies_bloc.dart';
import '../../blocs/movies/popular/popular_movies_bloc.dart';
import '../../blocs/movies/top_rated/top_rated_movies_bloc.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<NowPlayingMoviesBloc>()
            ..add(const GetNowPlayingMoviesEvent()),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularMoviesBloc>()
            ..add(const GetPopularMoviesEvent()),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedMoviesBloc>()
            ..add(const GetTopRatedMoviesEvent()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Movies"),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(page: const SearchMoviePage());
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              const SizedBox(
                height: 5.0,
              ),
              BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                builder: (context, state) {
                  if (state is NowPlayingMoviesLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingMoviesHasDataState) {
                    return MovieCard(
                      movies: state.result,
                    );
                  } else if (state is NowPlayingMoviesErrorState) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              SubHeading(
                onTap: () {
                  Get.to(page: const PopularMoviesPage());
                },
                title: "Popular",
              ),
              BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                builder: (context, state) {
                  if (state is PopularMoviesLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMoviesHasDataState) {
                    return MovieCard(
                      movies: state.result,
                    );
                  } else if (state is PopularMoviesErrorState) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              SubHeading(
                onTap: () {
                  Get.to(page: const TopRatedMoviesPage());
                },
                title: "Top Rated",
              ),
              BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                builder: (context, state) {
                  if (state is TopRatedMoviesLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedMoviesHasDataState) {
                    return MovieCard(
                      movies: state.result,
                    );
                  } else if (state is TopRatedMoviesErrorState) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
