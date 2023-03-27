import 'package:ditonton_yuk/presentation/widgets/tv_series/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton_yuk/injection.dart' as di;
import '../../../domain/entities/tv_series_entity.dart';
import '../../blocs/tv_series/watchlist/watchlist_tv_series_bloc.dart';

class WatchListTvSeriesPage extends StatelessWidget {
  const WatchListTvSeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<WatchlistTvSeriesBloc>()
        ..add(const GetWatchlistTvSeriesEvent()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 8),
          child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
            builder: (context, state) {
              if (state is WatchlistTvSeriesLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WatchlistTvSeriesHasDataState) {
                return ListView.builder(
                  itemCount: state.result.length,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    final TvSeriesEntity tvSeries = state.result[index];
                    return TvSeriesCardList(tvSeries: tvSeries);
                  },
                );
              } else if (state is WatchlistTvSeriesErrorState) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.visibility_off, size: 32),
                      SizedBox(height: 2),
                      Text('Empty Watchlist'),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
