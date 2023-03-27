import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_yuk/presentation/pages/tv_series/season_detail_page.dart';
import 'package:ditonton_yuk/state_util.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/season_entity.dart';
import '../../../utils/constants.dart';

class CardSeason extends StatelessWidget {
  final int tvId;
  final List<SeasonEntity> seasons;
  const CardSeason({
    super.key,
    required this.tvId,
    required this.seasons,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: seasons.length,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          final season = seasons[index];
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Stack(
              children: [
                Container(
                  width: 100.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: season.posterPath != null
                                ? '$baseImageUrl${season.posterPath}'
                                : 'https://i.ibb.co/TWLKGMY/No-Image-Available.jpg',
                            width: 100,
                            fit: BoxFit.cover,
                            placeholder: (_, __) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorWidget: (_, __, error) {
                              return Container(
                                color: Colors.black26,
                                child: const Center(
                                  child: Text('No Image'),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Center(
                            child: Text(
                              season.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                            page: SeasonDetailPage(
                          id: tvId,
                          seasonNumber: season.seasonNumber,
                        ));
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
