import 'package:tmdb_app/core/network/api_result.dart';
import 'package:tmdb_app/features/movies/domain/entities/movie.dart';
import 'package:tmdb_app/features/movies/domain/repositories/movies_repository.dart';


class GetPopularMovies {
  final MoviesRepository repo;

  GetPopularMovies(this.repo);

  Future<ApiResult<List<Movie>>> call({required int page}) {
    return repo.getPopularMovies(page: page);
  }
}

