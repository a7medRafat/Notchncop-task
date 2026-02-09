class Env {
  static const String tmdbBearer = String.fromEnvironment('TMDB_BEARER');

  static const String baseUrl = String.fromEnvironment(
    'TMDB_BASE_URL',
    defaultValue: 'https://api.themoviedb.org/3',
  );

  static const String imageBaseUrl = String.fromEnvironment(
    'TMDB_IMAGE_BASE_URL',
    defaultValue: 'https://image.tmdb.org/t/p',
  );

  static String get authorizationHeaderValue {
    if (tmdbBearer.isEmpty) {
      throw StateError('TMDB_BEARER not configured');
    }
    return tmdbBearer.startsWith('Bearer ') ? tmdbBearer : 'Bearer $tmdbBearer';
  }
}
