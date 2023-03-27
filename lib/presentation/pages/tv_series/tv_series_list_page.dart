import 'package:ditonton_yuk/presentation/blocs/tv_series/popular/popular_tv_series_bloc.dart';
import 'package:ditonton_yuk/presentation/blocs/tv_series/top_rated/top_rated_tv_series_bloc.dart';
import 'package:ditonton_yuk/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:ditonton_yuk/presentation/pages/tv_series/search_tv_series_page.dart';
import 'package:ditonton_yuk/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:ditonton_yuk/presentation/widgets/sub_heading.dart';
import 'package:ditonton_yuk/presentation/widgets/tv_series/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton_yuk/injection.dart' as di;
import '../../../state_util.dart';
import '../../../utils/constants.dart';
import '../../blocs/tv_series/now_playing/now_playing_tv_series_bloc.dart';

class TvSeriesListPage extends StatelessWidget {
  const TvSeriesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<NowPlayingTvSeriesBloc>()
            ..add(const GetNowPlayingTvSeriesEvent()),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularTvSeriesBloc>()
            ..add(const GetPopularTvSeriesEvent()),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedTvSeriesBloc>()
            ..add(const GetTopRatedTvSeriesEvent()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tv Series"),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(page: const SearchTvSeriesPage());
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              const SizedBox(
                height: 5.0,
              ),
              BlocBuilder<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
                builder: (_, state) {
                  if (state is NowPlayingTvSeriesLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingTvSeriesHasDataState) {
                    return TvSeriesCard(
                      tvSeries: state.result,
                    );
                  } else if (state is NowPlayingTvSeriesErrorState) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              SubHeading(
                onTap: () {
                  Get.to(page: const PopularTvSeriesPage());
                },
                title: "Popular",
              ),
              BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
                builder: (_, state) {
                  if (state is PopularTvSeriesLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTvSeriesHasDataState) {
                    return TvSeriesCard(
                      tvSeries: state.result,
                    );
                  } else if (state is PopularTvSeriesErrorState) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              SubHeading(
                onTap: () {
                  Get.to(page: const TopRatedTvSeriesPage());
                },
                title: "Top Rated",
              ),
              BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
                builder: (_, state) {
                  if (state is TopRatedTvSeriesLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvSeriesHasDataState) {
                    return TvSeriesCard(
                      tvSeries: state.result,
                    );
                  } else if (state is TopRatedTvSeriesErrorState) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
