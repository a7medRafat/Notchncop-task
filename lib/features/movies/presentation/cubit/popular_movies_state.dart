import 'package:equatable/equatable.dart';
import 'package:tmdb_app/features/movies/domain/entities/movie.dart';

class PopularMoviesState extends Equatable {
  final List<Movie> movies;
  final int nextPage;
  final bool isInitialLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;

  const PopularMoviesState({
    required this.movies,
    required this.nextPage,
    required this.isInitialLoading,
    required this.isLoadingMore,
    required this.hasMore,
    required this.error,
  });

  factory PopularMoviesState.initial() => const PopularMoviesState(
    movies: [],
    nextPage: 1,
    isInitialLoading: true,
    isLoadingMore: false,
    hasMore: true,
    error: null,
  );

  PopularMoviesState copyWith({
    List<Movie>? movies,
    int? nextPage,
    bool? isInitialLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
  }) {
    return PopularMoviesState(
      movies: movies ?? this.movies,
      nextPage: nextPage ?? this.nextPage,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    movies,
    nextPage,
    isInitialLoading,
    isLoadingMore,
    hasMore,
    error,
  ];
}
