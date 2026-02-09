import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:tmdb_app/core/config/api_urls.dart';
import 'package:tmdb_app/features/movies/data/models/movie_details_dto.dart';
import 'package:tmdb_app/features/movies/data/models/movie_list_response_dto.dart';

part 'tmdb_remote_data_source.g.dart';

@RestApi(baseUrl: ApiUrls.baseUrl)
abstract class TmdbRemoteDataSource {
  factory TmdbRemoteDataSource(Dio dio, {String baseUrl}) =
      _TmdbRemoteDataSource;

  @GET(ApiUrls.popularMovie)
  Future<MovieListResponseDto> getPopularMovies({
    @Query('include_adult') bool includeAdult = false,
    @Query('include_video') bool includeVideo = false,
    @Query('language') String language = 'en-US',
    @Query('page') int page = 1,
    @Query('sort_by') String sortBy = 'popularity.desc',
  });

  @GET(ApiUrls.movieDetails)
  Future<MovieDetailsDto> getMovieDetails(
    @Path('movie_id') int movieId, {
    @Query('language') String language = 'en-US',
  });
}
