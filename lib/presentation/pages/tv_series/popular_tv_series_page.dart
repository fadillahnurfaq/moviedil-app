import 'package:ditonton_yuk/presentation/blocs/tv_series/popular/popular_tv_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton_yuk/injection.dart' as di;
import '../../widgets/tv_series/tv_series_card_list.dart';

class PopularTvSeriesPage extends StatelessWidget {
  const PopularTvSeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<PopularTvSeriesBloc>()
        ..add(const GetPopularTvSeriesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Popular TV Series'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
            builder: (context, state) {
              if (state is PopularTvSeriesLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularTvSeriesHasDataState) {
                return ListView.builder(
                  itemBuilder: (_, index) {
                    final tvSeries = state.result[index];
                    return TvSeriesCardList(tvSeries: tvSeries);
                  },
                  itemCount: state.result.length,
                );
              } else if (state is PopularTvSeriesErrorState) {
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
