import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_app/core/di/injection.dart';
import 'package:tmdb_app/core/widgets/app_error_view.dart';
import 'package:tmdb_app/core/widgets/skeleton_list.dart';
import 'package:tmdb_app/features/movies/presentation/cubit/popular_movies_cubit.dart';
import 'package:tmdb_app/features/movies/presentation/cubit/popular_movies_state.dart';
import 'package:tmdb_app/features/movies/presentation/widgets/movie_list_item.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({super.key});

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  late final ScrollController _controller;
  late final PopularMoviesCubit _cubit;

  static const double _prefetchThresholdPx = 700;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<PopularMoviesCubit>()..loadFirstPage();
    _controller = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!_controller.hasClients) return;

    final remaining = _controller.position.extentAfter;
    if (remaining < _prefetchThresholdPx) {
      _cubit.loadMoreIfNeeded();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
        builder: (context, state) {
          if (state.isInitialLoading) {
            return const SkeletonMovieGrid(itemCount: 10);
          }

          if (state.error != null && state.movies.isEmpty) {
            return AppErrorView(
              message: state.error!,
              onRetry: () => context.read<PopularMoviesCubit>().loadFirstPage(),
            );
          }

          return RefreshIndicator(
            onRefresh: () => context.read<PopularMoviesCubit>().loadFirstPage(),
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 0.55,
              ),
              itemCount: state.movies.length,
              itemBuilder: (_, index) {
                return MovieGridItem(movie: state.movies[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
