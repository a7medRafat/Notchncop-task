import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/favorites/domain/usecases/toggle_favorite.dart';
import 'package:tmdb_app/features/favorites/domain/usecases/watch_favorites.dart';
import 'package:tmdb_app/features/movies/domain/entities/movie.dart';
import 'package:tmdb_app/features/movies/domain/entities/movie_details.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final WatchFavorites watchFavorites;
  final ToggleFavorite toggleFavorite;

  FavoritesCubit({required this.watchFavorites, required this.toggleFavorite})
    : super(FavoritesState.initial());

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final map = await watchFavorites.loadAll();
      emit(state.copyWith(isLoading: false, favorites: map, error: null));
    } catch (_) {
      emit(state.copyWith(isLoading: false, error: 'Failed to load favorites'));
    }
  }

  Future<void> toggle(Movie movie) async {
    final prev = state.favorites;

    final next = Map<int, Movie>.from(prev);
    final isFav = next.containsKey(movie.id);
    if (isFav) {
      next.remove(movie.id);
    } else {
      next[movie.id] = movie;
    }
    emit(state.copyWith(favorites: next, error: null));

    try {
      await toggleFavorite.toggle(movie);
    } catch (_) {
      emit(state.copyWith(favorites: prev, error: 'Failed to update favorite'));
    }
  }

  Future<void> toggleFromDetails(MovieDetails details) async {
    final prev = state.favorites;

    final movie = Movie(
      id: details.id,
      title: details.title,
      posterPath: details.posterPath,
      releaseDate: details.releaseDate,
      voteAverage: details.voteAverage,
    );

    final next = Map<int, Movie>.from(prev);
    final isFav = next.containsKey(details.id);
    if (isFav) {
      next.remove(details.id);
    } else {
      next[details.id] = movie;
    }
    emit(state.copyWith(favorites: next, error: null));

    try {
      if (isFav) {
        await toggleFavorite.toggle(movie);
      } else {
        await toggleFavorite.upsertFromDetails(details);
      }
    } catch (_) {
      emit(state.copyWith(favorites: prev, error: 'Failed to update favorite'));
    }
  }
}
