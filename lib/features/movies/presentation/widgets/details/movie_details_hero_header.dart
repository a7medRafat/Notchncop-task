import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_app/core/extensions/data_extension.dart';
import 'package:tmdb_app/core/functions/app_functions.dart';
import 'package:tmdb_app/core/helpers/app_strings.dart';
import 'package:tmdb_app/core/helpers/spacing.dart';
import 'package:tmdb_app/core/widgets/favorite_icon_button.dart';
import 'package:tmdb_app/core/widgets/movie_poster_card.dart';
import 'package:tmdb_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:tmdb_app/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:tmdb_app/features/movies/domain/entities/movie_details.dart';
import 'package:tmdb_app/features/movies/presentation/widgets/details/movie_backdrop_image.dart';
import 'package:tmdb_app/features/movies/presentation/widgets/details/movie_meta_chips_line.dart';
import 'package:tmdb_app/features/movies/presentation/widgets/details/score_ring.dart';

class MovieDetailsHeroHeader extends StatelessWidget {
  final MovieDetails details;

  const MovieDetailsHeroHeader({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final year = details.releaseDate.yearOrDash;

    return SizedBox(
      height: 340.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          MovieBackdropImage(backdropPath: details.backdropPath),

          const MovieBackdropGradient(),

          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const BackButton(color: Colors.white),
                      const Spacer(),
                      BlocSelector<FavoritesCubit, FavoritesState, bool>(
                        selector: (s) => s.isFavorite(details.id),
                        builder: (_, isFav) {
                          return FavoriteIconButton(
                            isFavorite: isFav,
                            onPressed: () => context
                                .read<FavoritesCubit>()
                                .toggleFromDetails(details),
                            background: Colors.black.withAlpha(35),
                            iconSize: 20.sp,
                          );
                        },
                      ),
                    ],
                  ),

                  verticalSpace(10),

                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MoviePosterCard(posterPath: details.posterPath),

                        horizontalSpace(14),

                        Expanded(
                          child: _HeaderRight(details: details, year: year),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderRight extends StatelessWidget {
  final MovieDetails details;
  final String year;

  const _HeaderRight({required this.details, required this.year});

  @override
  Widget build(BuildContext context) {
    final meta = AppFunctions.from(details);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RichText(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(text: details.title),
              TextSpan(
                text: year == '—' ? '' : ' ($year)',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        verticalSpace(8),

        MovieMetaChipsLine(text: meta),

        verticalSpace(14),

        Row(
          children: [
            ScoreRing(score: details.voteAverage),

            horizontalSpace(10),

            Text(
              AppStrings.userScore,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}



class MovieBackdropGradient extends StatelessWidget {
  const MovieBackdropGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.55),
            Colors.black.withOpacity(0.45),
            Colors.black.withOpacity(0.70),
          ],
        ),
      ),
    );
  }
}

