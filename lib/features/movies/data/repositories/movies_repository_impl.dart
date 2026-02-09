import 'package:dio/dio.dart';
import 'package:tmdb_app/core/error/api_error_handler.dart';
import 'package:tmdb_app/core/error/failure.dart';
import 'package:tmdb_app/core/network/api_result.dart';
import 'package:tmdb_app/core/network/network_connection.dart';
import 'package:tmdb_app/features/movies/data/datasources/tmdb_remote_data_source.dart';
import 'package:tmdb_app/features/movies/domain/entities/movie.dart';
import 'package:tmdb_app/features/movies/domain/entities/movie_details.dart';
import 'package:tmdb_app/features/movies/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final TmdbRemoteDataSource remote;
  final NetworkConnection network;

  MoviesRepositoryImpl(this.remote, {required this.network});

  @override
  Future<ApiResult<List<Movie>>> getPopularMovies({required int page}) async {
    final connected = await network.isConnected();
    if (!connected) {
      return const ApiFailure(Failure('check_internet'));
    }

    try {
      final response = await remote.getPopularMovies(page: page);
      final movies = response.results.map((dto) => dto.toEntity()).toList();
      return ApiSuccess(movies);
    } on DioException catch (e) {
      return ApiFailure(Failure(ApiErrorHandler.handle(e)));
    } catch (_) {
      return const ApiFailure(Failure('server_error'));
    }
  }

  @override
  Future<ApiResult<MovieDetails>> getMovieDetails({
    required int movieId,
  }) async {
    final connected = await network.isConnected();
    if (!connected) {
      return const ApiFailure(Failure('check_internet'));
    }

    try {
      final dto = await remote.getMovieDetails(movieId);
      return ApiSuccess(dto.toEntity());
    } on DioException catch (e) {
      return ApiFailure(Failure(ApiErrorHandler.handle(e)));
    } catch (_) {
      return const ApiFailure(Failure('server_error'));
    }
  }
}
