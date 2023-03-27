import 'package:ditonton_yuk/presentation/widgets/movies/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie_entity.dart';
import '../../blocs/movies/popular/popular_movies_bloc.dart';
import 'package:ditonton_yuk/injection.dart' as di;

class PopularMoviesPage extends StatelessWidget {
  const PopularMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.locator<PopularMoviesBloc>()..add(const GetPopularMoviesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Popular Movies"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
              builder: (context, state) {
                if (state is PopularMoviesLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMoviesHasDataState) {
                  return ListView.builder(
                    itemCount: state.result.length,
                    itemBuilder: (context, index) {
                      final MovieEntity movie = state.result[index];
                      return MovieCardList(
                        movie: movie,
                      );
                    },
                  );
                } else if (state is PopularMoviesErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(
                    child: Text("Emty Data"),
                  );
                }
              },
            )),
      ),
    );
  }
}
