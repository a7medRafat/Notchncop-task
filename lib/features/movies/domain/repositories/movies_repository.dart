import 'package:tmdb_app/core/network/api_result.dart';
import 'package:tmdb_app/features/movies/domain/entities/movie.dart';
import 'package:tmdb_app/features/movies/domain/entities/movie_details.dart';

abstract class MoviesRepository {
  Future<ApiResult<List<Movie>>> getPopularMovies({required int page});

  Future<ApiResult<MovieDetails>> getMovieDetails({required int movieId});
}
