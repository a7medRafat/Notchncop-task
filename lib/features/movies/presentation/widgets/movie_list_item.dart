import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/core/extensions/data_extension.dart';
import 'package:tmdb_app/core/helpers/spacing.dart';
import 'package:tmdb_app/features/movies/domain/entities/movie.dart';
import 'package:tmdb_app/features/movies/presentation/widgets/poster_sectiom.dart';

class MovieGridItem extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;

  const MovieGridItem({super.key, required this.movie, this.onTap});

  @override
  Widget build(BuildContext context) {
    final date = movie.releaseDate.yearOrDash;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap ?? () => context.push('/movie/${movie.id}'),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(6),
              blurRadius: 12.r,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: PosterSection(
                  posterPath: movie.posterPath,
                  rating: movie.voteAverage,
                  movie: movie,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 56.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpace(6),
                    Text(
                      date,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
