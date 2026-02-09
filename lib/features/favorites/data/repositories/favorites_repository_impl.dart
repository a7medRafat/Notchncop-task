import '../../../movies/domain/entities/movie.dart';
import '../../../movies/domain/entities/movie_details.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_local_data_source.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource local;

  FavoritesRepositoryImpl(this.local);

  Map<int, Movie>? _cache;

  @override
  Future<Map<int, Movie>> loadAll() async {
    _cache = await local.loadAll();
    return _cache!;
  }

  Future<Map<int, Movie>> _ensureCache() async {
    return _cache ??= await local.loadAll();
  }

  @override
  Future<void> toggle(Movie movie) async {
    final map = await _ensureCache();
    if (map.containsKey(movie.id)) {
      map.remove(movie.id);
    } else {
      map[movie.id] = movie;
    }
    await local.saveAll(map);
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    final map = await _ensureCache();
    return map.containsKey(movieId);
  }

  @override
  Future<void> upsertFromDetails(MovieDetails details) async {
    final map = await _ensureCache();
    map[details.id] = Movie(
      id: details.id,
      title: details.title,
      posterPath: details.posterPath,
      releaseDate: details.releaseDate,
      voteAverage: details.voteAverage,
    );
    await local.saveAll(map);
  }
}
