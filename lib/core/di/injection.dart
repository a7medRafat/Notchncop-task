import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_app/core/network/dio_client.dart';
import 'package:tmdb_app/app/router.dart';
import 'package:tmdb_app/core/network/network_connection.dart';
import 'package:tmdb_app/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:tmdb_app/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:tmdb_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:tmdb_app/features/favorites/domain/usecases/toggle_favorite.dart';
import 'package:tmdb_app/features/favorites/domain/usecases/watch_favorites.dart';
import 'package:tmdb_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:tmdb_app/features/movies/data/datasources/tmdb_remote_data_source.dart';
import 'package:tmdb_app/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:tmdb_app/features/movies/domain/repositories/movies_repository.dart';
import 'package:tmdb_app/features/movies/domain/usecases/get_movie_details.dart';
import 'package:tmdb_app/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:tmdb_app/features/movies/presentation/cubit/movie_details_cubit.dart';
import 'package:tmdb_app/features/movies/presentation/cubit/popular_movies_cubit.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  Dio dio = DioFactory.getDio();

  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<NetworkConnection>(() => NetworkConnection());

  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());

  getIt.registerLazySingleton<TmdbRemoteDataSource>(
    () => TmdbRemoteDataSource(dio),
  );

  getIt.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(
      getIt<TmdbRemoteDataSource>(),
      network: getIt<NetworkConnection>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetPopularMovies(getIt<MoviesRepository>()),
  );
  getIt.registerLazySingleton(() => GetMovieDetails(getIt<MoviesRepository>()));

  getIt.registerFactory(() => PopularMoviesCubit(getIt<GetPopularMovies>()));
  getIt.registerFactory(() => MovieDetailsCubit(getIt<GetMovieDetails>()));

  getIt.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSource(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(getIt<FavoritesLocalDataSource>()),
  );

  getIt.registerLazySingleton(
    () => ToggleFavorite(getIt<FavoritesRepository>()),
  );
  getIt.registerLazySingleton(
    () => WatchFavorites(getIt<FavoritesRepository>()),
  );

  getIt.registerFactory(
    () => FavoritesCubit(
      watchFavorites: getIt<WatchFavorites>(),
      toggleFavorite: getIt<ToggleFavorite>(),
    ),
  );
}
