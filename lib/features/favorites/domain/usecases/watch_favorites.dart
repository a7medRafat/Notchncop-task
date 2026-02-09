import '../../../movies/domain/entities/movie.dart';
import '../repositories/favorites_repository.dart';

class WatchFavorites {
  final FavoritesRepository repo;

  WatchFavorites(this.repo);

  Future<Map<int, Movie>> loadAll() => repo.loadAll();
}
