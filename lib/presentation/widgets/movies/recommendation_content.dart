import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../state_util.dart';
import '../../../utils/constants.dart';
import '../../../utils/state_enum.dart';

import '../../blocs/movies/detail/detail_movie_bloc.dart';
import '../../pages/movies/movie_detail_page.dart';

class RecommendationContent extends StatelessWidget {
  const RecommendationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailMovieBloc, DetailMovieState>(
      builder: (context, state) {
        final recommendationsState = state.movieRecommendationsState;
        if (recommendationsState == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (recommendationsState == RequestState.loaded) {
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.movieRecommendations.length,
              itemBuilder: (context, index) {
                final movie = state.movieRecommendations[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: '$baseImageUrl${movie.posterPath}',
                          placeholder: (_, __) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (_, __, ___) => const Icon(Icons.error),
                        ),
                      ),
                      Positioned.fill(
                          child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16.0),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            Get.off(
                              page: MovieDetailPage(id: movie.id),
                            );
                          },
                        ),
                      ))
                    ],
                  ),
                );
              },
            ),
          );
        } else if (recommendationsState == RequestState.error) {
          return Text(state.message);
        } else {
          return const Text('No Recommendations');
        }
      },
    );
  }
}
