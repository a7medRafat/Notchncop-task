import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/core/functions/app_functions.dart';
import 'package:tmdb_app/core/resources/AppColors.dart';
import 'package:tmdb_app/core/widgets/app_container.dart';

class MoviePoster extends StatelessWidget {
  final String? posterPath;
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const MoviePoster({
    super.key,
    required this.posterPath,
    required this.width,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
  });

  @override
  Widget build(BuildContext context) {
    final url = AppFunctions.posterUrl(posterPath);

    return ClipRRect(
      borderRadius: borderRadius,
      child: AppContainer(
        width: width,
        height: height,
        color: AppColors.border,
        child: url == null
            ? const Icon(Icons.image_not_supported_outlined)
            : CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.border),
                errorWidget: (_, __, ___) =>
                    const Icon(Icons.broken_image_outlined),
              ),
      ),
    );
  }
}
