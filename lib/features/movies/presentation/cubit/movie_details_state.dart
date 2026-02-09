import 'package:equatable/equatable.dart';
import '../../domain/entities/movie_details.dart';

class MovieDetailsState extends Equatable {
  final bool isLoading;
  final MovieDetails? details;
  final String? error;

  const MovieDetailsState({
    required this.isLoading,
    required this.details,
    required this.error,
  });

  factory MovieDetailsState.initial() =>
      const MovieDetailsState(isLoading: true, details: null, error: null);

  MovieDetailsState copyWith({
    bool? isLoading,
    MovieDetails? details,
    String? error,
  }) {
    return MovieDetailsState(
      isLoading: isLoading ?? this.isLoading,
      details: details ?? this.details,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, details, error];
}
