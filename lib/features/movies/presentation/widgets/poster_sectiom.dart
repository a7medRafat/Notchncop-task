import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_app/core/resources/AppColors.dart';
import 'package:tmdb_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:tmdb_app/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:tmdb_app/features/movies/domain/entities/movie.dart';
import 'package:tmdb_app/features/movies/presentation/widgets/movie_poster.dart';
import 'package:tmdb_app/features/movies/presentation/widgets/rating_badge.dart';

class PosterSection extends StatelessWidget {
  final String? posterPath;
  final double? rating;
  final Movie movie;

  const PosterSection({
    super.key,
    required this.posterPath,
    required this.rating,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: Stack(
          children: [
            MoviePoster(
              posterPath: posterPath,
              width: double.infinity,
              height: double.infinity,
            ),

            Positioned(
              bottom: 10.h,
              left: 10.w,
              child: RatingBadge(rating: rating),
            ),

            Positioned(
              top: 8.h,
              right: 8.w,
              child: _FavoriteButton(movie: movie),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final Movie movie;

  const _FavoriteButton({required this.movie});

  @override
  Widget build(BuildContext context) {
    int movieId = movie.id;
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      buildWhen: (p, n) => p.isFavorite(movieId) != n.isFavorite(movieId),
      builder: (context, state) {
        final isFav = state.isFavorite(movieId);

        return Material(
          color: Colors.black.withOpacity(0.45),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              context.read<FavoritesCubit>().toggle(movie);
            },
            child: Padding(
              padding: EdgeInsets.all(6.w),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, anim) =>
                    ScaleTransition(scale: anim, child: child),
                child: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey(isFav),
                  color: isFav
                      ? AppColors.favoriteActive
                      : AppColors.favoriteInactive,
                  size: 18.sp,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
