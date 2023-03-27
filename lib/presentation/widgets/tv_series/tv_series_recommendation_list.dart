import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_yuk/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:ditonton_yuk/state_util.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/tv_series_entity.dart';
import '../../../utils/constants.dart';

class TvSeriesRecommendationList extends StatelessWidget {
  final List<TvSeriesEntity> tvSeriesList;

  const TvSeriesRecommendationList({required this.tvSeriesList, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tvSeriesList[index];
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: CachedNetworkImage(
                    imageUrl: '$baseImageUrl${tvSeries.posterPath}',
                    placeholder: (_, __) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorWidget: (_, __, error) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        Get.off(page: TvSeriesDetailPage(id: tvSeries.id));
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: tvSeriesList.length,
      ),
    );
  }
}
