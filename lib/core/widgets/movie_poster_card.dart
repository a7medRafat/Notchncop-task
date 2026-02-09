import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_app/features/movies/presentation/widgets/movie_poster.dart';

class MoviePosterCard extends StatelessWidget {
  final String? posterPath;

  const MoviePosterCard({super.key, required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: SizedBox(
        width: 120.w,
        height: 180.h,
        child: MoviePoster(
          posterPath: posterPath,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
