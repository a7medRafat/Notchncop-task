import 'package:flutter/material.dart';
import 'package:tmdb_app/core/functions/app_functions.dart';

class MovieBackdropImage extends StatelessWidget {
  final String? backdropPath;

  const MovieBackdropImage({super.key, required this.backdropPath});

  @override
  Widget build(BuildContext context) {
    final url = AppFunctions.backdropUrl(backdropPath, size: 'w1280');

    if (url == null) {
      return Container(color: Colors.black12);
    }

    return Image.network(
      url,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      errorBuilder: (_, __, ___) => Container(color: Colors.black12),
    );
  }
}
