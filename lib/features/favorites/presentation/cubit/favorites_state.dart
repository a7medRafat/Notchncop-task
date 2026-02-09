import 'package:equatable/equatable.dart';
import '../../../movies/domain/entities/movie.dart';

class FavoritesState extends Equatable {
  final bool isLoading;
  final Map<int, Movie> favorites; // id -> movie summary
  final String? error;

  const FavoritesState({
    required this.isLoading,
    required this.favorites,
    required this.error,
  });

  factory FavoritesState.initial() =>
      const FavoritesState(isLoading: true, favorites: {}, error: null);

  FavoritesState copyWith({
    bool? isLoading,
    Map<int, Movie>? favorites,
    String? error,
  }) {
    return FavoritesState(
      isLoading: isLoading ?? this.isLoading,
      favorites: favorites ?? this.favorites,
      error: error,
    );
  }

  bool isFavorite(int movieId) => favorites.containsKey(movieId);

  @override
  List<Object?> get props => [isLoading, favorites, error];
}
