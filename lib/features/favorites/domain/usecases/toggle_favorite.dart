import '../../../movies/domain/entities/movie.dart';
import '../../../movies/domain/entities/movie_details.dart';
import '../repositories/favorites_repository.dart';

class ToggleFavorite {
  final FavoritesRepository repo;

  ToggleFavorite(this.repo);

  Future<void> toggle(Movie movie) => repo.toggle(movie);

  Future<void> upsertFromDetails(MovieDetails details) =>
      repo.upsertFromDetails(details);
}
