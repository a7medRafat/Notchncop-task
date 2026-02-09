import 'package:go_router/go_router.dart';
import '../features/movies/presentation/screens/movie_details_screen.dart';
import '../features/shell/presentation/shell_screen.dart';

class AppRoutes {
  static const shell = '/';
  static const movieDetails = '/movie/:id';
}

class AppRouter {
  final GoRouter router;

  AppRouter()
    : router = GoRouter(
        initialLocation: AppRoutes.shell,
        routes: [
          GoRoute(
            path: AppRoutes.shell,
            builder: (_, __) => const ShellScreen(),
            routes: [
              GoRoute(
                path: 'movie/:id',
                name: AppRoutes.movieDetails,
                builder: (context, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  return MovieDetailsScreen(movieId: id);
                },
              ),
            ],
          ),
        ],
      );
}
