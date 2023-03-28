import 'package:ditonton_yuk/presentation/widgets/movies/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../../utils/utils.dart';
import '../../blocs/movies/watchlist/watchlist_movies_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({super.key});

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    context.read<WatchlistMoviesBloc>().add(const GetWatchlistMoviesEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMoviesBloc>().add(const GetWatchlistMoviesEvent());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
        child: BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
          builder: (context, state) {
            if (state is WatchlistMoviesLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMoviesHasDataState) {
              return ListView.builder(
                itemCount: state.result.length,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  final MovieEntity movie = state.result[index];
                  return MovieCardList(movie: movie);
                },
              );
            } else if (state is WatchlistMoviesErrorState) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is WatchlistMoviesEmptyState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.visibility_off,
                      size: 32,
                    ),
                    SizedBox(height: 2),
                    Text('Empty Watchlist'),
                  ],
                ),
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
