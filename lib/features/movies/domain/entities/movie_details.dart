import 'package:tmdb_app/features/movies/data/models/production_company.dart';

import 'movie.dart';

class MovieDetails extends Movie {
  final String? overview;
  final String? backdropPath;
  final List<String> genres;
  final int? runtime;

  final List<String> spokenLanguages;
  final List<String> productionCountries;
  final List<ProductionCompany> productionCompanies;

  final int? voteCount;
  final int? revenue;

  const MovieDetails({
    required super.id,
    required super.title,
    required super.posterPath,
    required super.releaseDate,
    required super.voteAverage,
    required this.overview,
    required this.backdropPath,
    required this.genres,
    required this.runtime,
    required this.spokenLanguages,
    required this.productionCountries,
    required this.productionCompanies,
    required this.voteCount,
    required this.revenue,
  });
}
