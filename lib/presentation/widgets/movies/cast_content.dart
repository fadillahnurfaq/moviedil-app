import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_yuk/domain/entities/cast_entity.dart';
import 'package:ditonton_yuk/presentation/blocs/movies/cast/cast_movie_bloc.dart';
import 'package:ditonton_yuk/presentation/pages/movies/detail_cast_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../state_util.dart';
import '../../../utils/constants.dart';

class CastContent extends StatelessWidget {
  const CastContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastMovieBloc, CastMovieState>(
      builder: (context, state) {
        if (state is CastMoviesLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CastMoviesHasDataState) {
          return SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.result.length,
              itemBuilder: (context, index) {
                final CastEntity cast = state.result[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              width: 100,
                              imageUrl: '$baseImageUrl${cast.profilePath}',
                              placeholder: (_, __) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (_, __, ___) =>
                                  const Icon(Icons.error),
                            ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(16.0),
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      page: DetailCastMoviePage(id: cast.id!),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          cast.name!,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is CastMoviesErrorState) {
          return Text(state.message);
        } else {
          return const Text('No Cast');
        }
      },
    );
  }
}
