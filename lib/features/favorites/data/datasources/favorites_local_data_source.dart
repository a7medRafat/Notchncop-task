import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../movies/data/models/movie_dto.dart';
import '../../../movies/domain/entities/movie.dart';

class FavoritesLocalDataSource {
  static const _key = 'favorites_movies_map'; // id -> Movie JSON
  final SharedPreferences prefs;

  FavoritesLocalDataSource(this.prefs);

  Future<Map<int, Movie>> loadAll() async {
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return {};

    final map = jsonDecode(raw) as Map<String, dynamic>;
    final result = <int, Movie>{};

    map.forEach((k, v) {
      final id = int.tryParse(k);
      if (id == null) return;
      if (v is Map<String, dynamic>) {
        result[id] = MovieDto.fromJson(v).toEntity();
      }
    });

    return result;
  }

  Future<void> saveAll(Map<int, Movie> movies) async {
    final map = <String, dynamic>{};
    movies.forEach((id, movie) {
      map[id.toString()] = MovieDto(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        releaseDate: movie.releaseDate,
        voteAverage: movie.voteAverage,
      ).toJson();
    });

    await prefs.setString(_key, jsonEncode(map));
  }
}
