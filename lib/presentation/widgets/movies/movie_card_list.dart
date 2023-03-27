import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_yuk/presentation/pages/movies/movie_detail_page.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/movie_entity.dart';
import '../../../state_util.dart';
import '../../../utils/constants.dart';

class MovieCardList extends StatelessWidget {
  final MovieEntity movie;
  const MovieCardList({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          Get.to(page: MovieDetailPage(id: movie.id));
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                width: Get.width,
                margin:
                    const EdgeInsets.only(left: 130.0, bottom: 8.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading5,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      movie.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  width: 80,
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (_, __, ___) => const Icon(Icons.error),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
