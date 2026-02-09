import '../../../movies/domain/entities/movie.dart';
import '../../../movies/domain/entities/movie_details.dart';

abstract class FavoritesRepository {
  Future<Map<int, Movie>> loadAll();

  Future<void> toggle(Movie movie);

  Future<bool> isFavorite(int movieId);

  Future<void> upsertFromDetails(MovieDetails details);
}
