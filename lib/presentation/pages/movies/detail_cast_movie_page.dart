import 'package:ditonton_yuk/presentation/blocs/movies/cast_detail/cast_movie_detail_bloc.dart';
import 'package:ditonton_yuk/presentation/widgets/movies/cast_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton_yuk/injection.dart' as di;

class DetailCastMoviePage extends StatelessWidget {
  final int id;
  const DetailCastMoviePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.locator<CastMovieDetailBloc>()..add(GetCastDetailMovieEvent(id)),
      child: Scaffold(
        body: BlocBuilder<CastMovieDetailBloc, CastMovieDetailState>(
          builder: (context, state) {
            if (state is CastMoviesDetailLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CastMoviesDetailHasDataState) {
              return CastDetailContent(
                data: state.result,
              );
            } else if (state is CastMoviesDetailErrorState) {
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
