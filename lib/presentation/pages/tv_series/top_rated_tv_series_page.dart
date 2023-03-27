import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton_yuk/injection.dart' as di;
import '../../blocs/tv_series/top_rated/top_rated_tv_series_bloc.dart';
import '../../widgets/tv_series/tv_series_card_list.dart';

class TopRatedTvSeriesPage extends StatelessWidget {
  const TopRatedTvSeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<TopRatedTvSeriesBloc>()
        ..add(const GetTopRatedTvSeriesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Top Rated TV Series'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
            builder: (context, state) {
              if (state is TopRatedTvSeriesLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedTvSeriesHasDataState) {
                return ListView.builder(
                  itemBuilder: (_, index) {
                    final tvSeries = state.result[index];
                    return TvSeriesCardList(tvSeries: tvSeries);
                  },
                  itemCount: state.result.length,
                );
              } else if (state is TopRatedTvSeriesErrorState) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: Text('Error Get Top Rated TV Series'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
