import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_yuk/domain/entities/movie_detail.dart';
import 'package:ditonton_yuk/presentation/blocs/movies/detail/detail_movie_bloc.dart';
import 'package:ditonton_yuk/presentation/widgets/movies/cast_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../domain/entities/genre_entity.dart';
import '../../../state_util.dart';
import '../../../utils/constants.dart';
import 'recommendation_content.dart';

class MovieDetailContent extends StatelessWidget {
  final MovieDetail movieDetail;
  final bool isAddedWatchlist;
  const MovieDetailContent({
    super.key,
    required this.movieDetail,
    required this.isAddedWatchlist,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: "$baseImageUrl${movieDetail.posterPath}",
            width: Get.width,
            height: Get.height,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 56.0),
            child: DraggableScrollableSheet(
              minChildSize: 0.25,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  decoration: const BoxDecoration(
                    color: kRichBlack,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 4.0,
                            width: 48.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          movieDetail.title,
                          style: kHeading5,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (!isAddedWatchlist) {
                              context
                                  .read<DetailMovieBloc>()
                                  .add(AddWatchlistMovieEvent(movieDetail));
                            } else {
                              context.read<DetailMovieBloc>().add(
                                  RemoveFromWatchlistMovieEvent(movieDetail));
                            }
                          },
                          icon: isAddedWatchlist
                              ? const Icon(Icons.check)
                              : const Icon(Icons.add),
                          label: const Text("Watchlist"),
                        ),
                        Text(
                          _showGenres(movieDetail.genres),
                        ),
                        Text(
                          _showDuration(movieDetail.runtime),
                        ),
                        RatingBarIndicator(
                          rating: movieDetail.voteAverage / 2,
                          itemCount: 5,
                          itemSize: 24.0,
                          itemBuilder: (context, index) {
                            return const Icon(
                              Icons.star,
                              color: kMikadoYellow,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Overview',
                          style: kHeading6,
                        ),
                        Text(
                          movieDetail.overview,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Cast',
                          style: kHeading6,
                        ),
                        const CastContent(),
                        const SizedBox(height: 16),
                        Text(
                          'Recommendations',
                          style: kHeading6,
                        ),
                        const RecommendationContent(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: kRichBlack,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  // Get.back();
                  Navigator.pop(context);
                },
                child: const SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String _showGenres(List<GenreEntity> genres) {
    String result = '';

    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
