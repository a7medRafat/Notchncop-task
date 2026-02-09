import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_app/core/helpers/app_strings.dart';
import 'package:tmdb_app/core/widgets/app_empty_view.dart';
import 'package:tmdb_app/core/widgets/app_error_view.dart';
import 'package:tmdb_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:tmdb_app/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:tmdb_app/features/movies/presentation/widgets/movie_list_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null) {
          return AppErrorView(
            message: state.error!,
            onRetry: () => context.read<FavoritesCubit>().load(),
          );
        }

        final movies = state.favorites.values.toList()
          ..sort((a, b) => a.title.compareTo(b.title));

        if (movies.isEmpty) {
          return const AppEmptyView(
            title: AppStrings.favoritesEmptyTitle,
            subtitle: AppStrings.favoritesEmptySubtitle,
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: movies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.55,
          ),
          itemBuilder: (_, i) => MovieGridItem(movie: movies[i]),
        );
      },
    );
  }
}
