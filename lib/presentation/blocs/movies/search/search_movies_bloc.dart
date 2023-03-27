import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../domain/entities/movie_entity.dart';
import '../../../../domain/usecase/movies/search_movies.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final GetSearchMovies _searchMovies;

  SearchMoviesBloc(this._searchMovies) : super(SearchMoviesInitialState()) {
    on<SearchMoviesEvent>(
      (event, emit) async {
        if (event is SearchMoviesOnQueryChangedEvent) {
          final query = event.query;

          emit(SearchMoviesLoadingState());

          final result = await _searchMovies.execute(query);

          result.fold(
            (failure) => emit(SearchMoviesErrorState(failure.message)),
            (data) {
              if (data.isEmpty) {
                emit(SearchMoviesEmptyState());
              } else {
                emit(SearchMoviesHasDataState(data));
              }
            },
          );
        }
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
