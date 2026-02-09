import 'package:tmdb_app/core/network/api_result.dart';
import 'package:tmdb_app/features/movies/domain/entities/movie_details.dart';
import 'package:tmdb_app/features/movies/domain/repositories/movies_repository.dart';

class GetMovieDetails {
  final MoviesRepository repo;

  GetMovieDetails(this.repo);

  Future<ApiResult<MovieDetails>> call({required int movieId}) {
    return repo.getMovieDetails(movieId: movieId);
  }
}
