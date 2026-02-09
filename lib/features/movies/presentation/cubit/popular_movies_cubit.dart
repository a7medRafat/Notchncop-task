import 'dart:collection';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_popular_movies.dart';
import 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  bool _requestInFlight = false;
  final HashSet<int> _seenIds = HashSet<int>();

  PopularMoviesCubit(this._getPopularMovies)
    : super(PopularMoviesState.initial());

  Future<void> loadFirstPage() async {
    emit(PopularMoviesState.initial());
    _seenIds.clear();
    await _fetchNext(isInitial: true);
  }

  Future<void> loadMoreIfNeeded() async {
    if (!state.hasMore) return;
    if (_requestInFlight) return;
    if (state.isInitialLoading || state.isLoadingMore) return;
    await _fetchNext(isInitial: false);
  }

  Future<void> _fetchNext({required bool isInitial}) async {
    if (_requestInFlight) return;
    _requestInFlight = true;

    try {
      if (isInitial) {
        emit(state.copyWith(isInitialLoading: true, error: null));
      } else {
        emit(state.copyWith(isLoadingMore: true, error: null));
      }

      final page = state.nextPage;
      final result = await _getPopularMovies(page: page);

      result.when(
        success: (fetched) {
          final List<Movie> uniqueNew = [];
          for (final m in fetched) {
            if (_seenIds.add(m.id)) uniqueNew.add(m);
          }

          final merged = [...state.movies, ...uniqueNew];
          final hasMore = fetched.isNotEmpty;

          emit(
            state.copyWith(
              movies: merged,
              nextPage: page + 1,
              isInitialLoading: false,
              isLoadingMore: false,
              hasMore: hasMore,
              error: null,
            ),
          );
        },
        failure: (failure) {
          emit(
            state.copyWith(
              isInitialLoading: false,
              isLoadingMore: false,
              error: failure.message,
            ),
          );
        },
      );
    } finally {
      _requestInFlight = false;
    }
  }
}
