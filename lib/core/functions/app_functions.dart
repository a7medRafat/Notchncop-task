import 'package:tmdb_app/core/config/env.dart';
import 'package:tmdb_app/core/extensions/data_extension.dart';
import 'package:tmdb_app/features/movies/domain/entities/movie_details.dart';

class AppFunctions {
  static String from(MovieDetails d) {
    final date = d.releaseDate.yearOrDash;
    final genres = (d.genres).take(3).join(', ');
    final runtime = _runtimeText(d.runtime);

    final parts = <String>[];
    if (date != '—') parts.add(date);
    if (genres.isNotEmpty) parts.add(genres);
    if (runtime != null) parts.add(runtime);

    return parts.isEmpty ? '—' : parts.join(' • ');
  }

  static String? _runtimeText(int? minutes) {
    if (minutes == null || minutes <= 0) return null;
    final h = minutes ~/ 60;
    final m = minutes % 60;
    if (h <= 0) return '${m}m';
    return '${h}h ${m}m';
  }

  static String? posterUrl(String? posterPath, {String size = 'w342'}) {
    if (posterPath == null || posterPath.isEmpty) return null;
    return '${Env.imageBaseUrl}/$size$posterPath';
  }

  static String? backdropUrl(String? backdropPath, {String size = 'w1280'}) {
    if (backdropPath == null || backdropPath.isEmpty) return null;
    return '${Env.imageBaseUrl}/$size$backdropPath';
  }

  static String? logoUrl(String? logoPath, {String size = 'w92'}) {
    if (logoPath == null || logoPath.isEmpty) return null;
    return '${Env.imageBaseUrl}/$size$logoPath';
  }

  static String formatCompact(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }

  static String formatMoney(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final idxFromEnd = s.length - i;
      buf.write(s[i]);
      if (idxFromEnd > 1 && idxFromEnd % 3 == 1) buf.write(',');
    }
    return '\$${buf.toString()}';
  }
}
