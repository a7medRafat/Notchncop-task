import 'package:tmdb_app/features/movies/data/models/production_company.dart';
import 'package:tmdb_app/features/movies/data/models/production_company_dto.dart';
import 'package:tmdb_app/features/movies/domain/entities/movie_details.dart';

class MovieDetailsDto {
  final int id;
  final String title;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double? voteAverage;
  final int? voteCount;
  final int? revenue;
  final String? overview;
  final List<String> genres;
  final int? runtime;
  final List<String> spokenLanguages;
  final List<String> productionCountries;
  final List<ProductionCompanyDto> productionCompanies;

  MovieDetailsDto({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.revenue,
    required this.overview,
    required this.genres,
    required this.runtime,
    required this.spokenLanguages,
    required this.productionCountries,
    required this.productionCompanies,
  });

  factory MovieDetailsDto.fromJson(Map<String, dynamic> json) {
    final genres = (json['genres'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((e) => (e['name'] as String?)?.trim() ?? '')
        .where((e) => e.isNotEmpty)
        .toList();

    final spokenLanguages =
        (json['spoken_languages'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map((e) {
              final english = (e['english_name'] as String?)?.trim();
              final native = (e['name'] as String?)?.trim();
              final v = (english?.isNotEmpty == true)
                  ? english!
                  : (native ?? '');
              return v;
            })
            .where((e) => e.isNotEmpty)
            .toList();

    final productionCountries =
        (json['production_countries'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map((e) => (e['name'] as String?)?.trim() ?? '')
            .where((e) => e.isNotEmpty)
            .toList();

    final productionCompanies =
        (json['production_companies'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(ProductionCompanyDto.fromJson)
            .where((e) => e.id != 0)
            .toList();

    return MovieDetailsDto(
      id: (json['id'] as num).toInt(),
      title: (json['title'] as String?)?.trim().isNotEmpty == true
          ? (json['title'] as String).trim()
          : 'Untitled',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: json['release_date'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      revenue: (json['revenue'] as num?)?.toInt(),
      overview: json['overview'] as String?,
      runtime: (json['runtime'] as num?)?.toInt(),
      genres: genres,
      spokenLanguages: spokenLanguages,
      productionCountries: productionCountries,
      productionCompanies: productionCompanies,
    );
  }

  MovieDetails toEntity() => MovieDetails(
    id: id,
    title: title,
    posterPath: posterPath,
    releaseDate: releaseDate,
    voteAverage: voteAverage,
    voteCount: voteCount,
    revenue: revenue,
    overview: overview,
    backdropPath: backdropPath,
    genres: genres,
    runtime: runtime,
    spokenLanguages: spokenLanguages,
    productionCountries: productionCountries,
    productionCompanies: productionCompanies
        .map(
          (e) =>
              ProductionCompany(id: e.id, name: e.name, logoPath: e.logoPath),
        )
        .toList(),
  );
}
