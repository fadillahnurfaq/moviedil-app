import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_yuk/presentation/blocs/tv_series/watchlist_status/watchlist_status_tv_series_bloc.dart';
import 'package:ditonton_yuk/presentation/widgets/tv_series/tv_series_recommendation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../domain/entities/genre_entity.dart';
import '../../../domain/entities/tv_series_detail_entity.dart';
import '../../../state_util.dart';
import '../../../utils/constants.dart';
import '../../blocs/tv_series/recommendation/recommendation_tv_series_bloc.dart';
import 'card_season.dart';

class TvSeriesDetailContent extends StatelessWidget {
  final TvSeriesDetailEntity tvSeriesDetail;
  const TvSeriesDetailContent({super.key, required this.tvSeriesDetail});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: '$baseImageUrl${tvSeriesDetail.posterPath}',
            width: Get.width,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 56.0),
            child: DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                  ),
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
                          tvSeriesDetail.name,
                          style: kHeading5,
                        ),
                        BlocConsumer<WatchlistStatusTvSeriesBloc,
                            WatchlistStatusTvSeriesState>(
                          listener: (context, state) {
                            if (state.message ==
                                    WatchlistStatusTvSeriesBloc
                                        .watchlistAddSuccessMessage ||
                                state.message ==
                                    WatchlistStatusTvSeriesBloc
                                        .watchlistRemoveSuccessMessage) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message),
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(state.message),
                                  );
                                },
                              );
                            }
                          },
                          listenWhen: (oldState, newState) =>
                              oldState.message != newState.message &&
                              newState.message != '',
                          builder: (context, state) {
                            return ElevatedButton.icon(
                              onPressed: () {
                                if (!state.isAddedToWatchlist) {
                                  context
                                      .read<WatchlistStatusTvSeriesBloc>()
                                      .add(
                                        AddWatchlistTvSeriesEvent(
                                          tvSeriesDetail,
                                        ),
                                      );
                                } else {
                                  context
                                      .read<WatchlistStatusTvSeriesBloc>()
                                      .add(
                                        RemoveFromWatchlistTvSeriesEvent(
                                          tvSeriesDetail,
                                        ),
                                      );
                                }
                              },
                              icon: state.isAddedToWatchlist
                                  ? const Icon(Icons.check)
                                  : const Icon(Icons.add),
                              label: const Text("Watchlist"),
                            );
                          },
                        ),
                        Text(
                          _showGenres(tvSeriesDetail.genres),
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: tvSeriesDetail.voteAverage / 2,
                              itemCount: 5,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: kMikadoYellow,
                              ),
                              itemSize: 24,
                            ),
                            Text('${tvSeriesDetail.voteAverage}')
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Overview',
                          style: kHeading6,
                        ),
                        Text(
                          tvSeriesDetail.overview,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Seasons',
                          style: kHeading6,
                        ),
                        const SizedBox(height: 5),
                        CardSeason(
                          tvId: tvSeriesDetail.id,
                          seasons: tvSeriesDetail.seasons,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Recommendations',
                          style: kHeading6,
                        ),
                        const SizedBox(height: 5),
                        BlocBuilder<RecommendationTvSeriesBloc,
                            RecommendationTvSeriesState>(
                          builder: (_, state) {
                            if (state is RecommendationTvSeriesLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state
                                is RecommendationTvSeriesHasDataState) {
                              return TvSeriesRecommendationList(
                                tvSeriesList: state.result,
                              );
                            } else if (state
                                is RecommendationTvSeriesErrorState) {
                              return Center(
                                child: Text(state.message),
                              );
                            } else {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: 150,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.tv_off),
                                      SizedBox(height: 2),
                                      Text('No Recommendations'),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
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
                  Get.back();
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
}
