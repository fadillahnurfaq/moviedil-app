import 'package:ditonton_yuk/presentation/widgets/movies/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton_yuk/injection.dart' as di;
import '../../../domain/entities/movie_entity.dart';
import '../../blocs/movies/top_rated/top_rated_movies_bloc.dart';

class TopRatedMoviesPage extends StatelessWidget {
  const TopRatedMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.locator<TopRatedMoviesBloc>()..add(const GetTopRatedMoviesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Top Rated Movies"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
            builder: (context, state) {
              if (state is TopRatedMoviesLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedMoviesHasDataState) {
                return ListView.builder(
                  itemCount: state.result.length,
                  itemBuilder: (context, index) {
                    final MovieEntity movie = state.result[index];
                    return MovieCardList(
                      movie: movie,
                    );
                  },
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
        ),
      ),
    );
  }
}
