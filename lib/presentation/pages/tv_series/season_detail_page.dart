import 'package:ditonton_yuk/domain/entities/episode_entity.dart';
import 'package:ditonton_yuk/presentation/widgets/tv_series/episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton_yuk/injection.dart' as di;
import '../../../utils/constants.dart';
import '../../blocs/tv_series/season_detail/season_detail_bloc.dart';

class SeasonDetailPage extends StatelessWidget {
  final int id;
  final int seasonNumber;
  const SeasonDetailPage({
    super.key,
    required this.id,
    required this.seasonNumber,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<SeasonDetailBloc>()
        ..add(
          GetSeasonDetailEvent(
            id: id,
            seasonNumber: seasonNumber,
          ),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<SeasonDetailBloc, SeasonDetailState>(
            builder: (context, state) {
              if (state is SeasonDetailHasDataState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Season 1",
                      style: kHeading6.copyWith(fontSize: 18),
                    ),
                    Text(
                      '9 Episodes',
                      style: kSubtitle.copyWith(fontSize: 14),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        body: BlocBuilder<SeasonDetailBloc, SeasonDetailState>(
          builder: (context, state) {
            if (state is SeasonDetailLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SeasonDetailHasDataState) {
              final episodes = state.result.episodes;
              if (episodes.isEmpty) {
                return const Center(
                  child: Text('No Episodes'),
                );
              } else {
                return ListView.builder(
                  itemCount: episodes.length,
                  itemBuilder: (context, index) {
                    final EpisodeEntity episode = episodes[index];
                    return EpisodeCardList(
                      episode: episode,
                    );
                  },
                );
              }
            } else if (state is SeasonDetailErrorState) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Error Get Season'),
              );
            }
          },
        ),
      ),
    );
  }
}
