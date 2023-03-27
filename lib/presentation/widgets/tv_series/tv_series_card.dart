import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_yuk/domain/entities/tv_series_entity.dart';
import 'package:ditonton_yuk/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:ditonton_yuk/state_util.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class TvSeriesCard extends StatelessWidget {
  final List<TvSeriesEntity> tvSeries;

  const TvSeriesCard({super.key, required this.tvSeries});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          final item = tvSeries[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: CachedNetworkImage(
                    imageUrl: '$baseImageUrl${item.posterPath}',
                    placeholder: (_, __) => const Center(
                      child: CircularProgressIndicator(),
                    ),
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
                      Get.to(
                          page: TvSeriesDetailPage(
                        id: item.id,
                      ));
                    },
                  ),
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
