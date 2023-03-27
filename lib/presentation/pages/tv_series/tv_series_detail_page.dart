import 'package:ditonton_yuk/presentation/widgets/tv_series/tv_series_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton_yuk/injection.dart' as di;
import '../../blocs/tv_series/detail/detail_tv_series_bloc.dart';
import '../../blocs/tv_series/recommendation/recommendation_tv_series_bloc.dart';
import '../../blocs/tv_series/watchlist_status/watchlist_status_tv_series_bloc.dart';

class TvSeriesDetailPage extends StatelessWidget {
  final int id;
  const TvSeriesDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              di.locator<DetailTvSeriesBloc>()..add(GetDetailTvSeriesEvent(id)),
        ),
        BlocProvider(
          create: (context) => di.locator<RecommendationTvSeriesBloc>()
            ..add(GetRecommendationTvSeriesEvent(id)),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistStatusTvSeriesBloc>()
            ..add(LoadWatchlistStatusTvSeriesEvent(id)),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<DetailTvSeriesBloc, DetailTvSeriesState>(
          builder: (context, state) {
            if (state is DetailTvSeriesLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DetailTvSeriesHasDataState) {
              return TvSeriesDetailContent(tvSeriesDetail: state.result);
            } else if (state is DetailTvSeriesErrorState) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
