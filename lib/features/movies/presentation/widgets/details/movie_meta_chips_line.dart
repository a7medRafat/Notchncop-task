import 'package:flutter/material.dart';

class MovieMetaChipsLine extends StatelessWidget {
  final String text;

  const MovieMetaChipsLine({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.white.withOpacity(0.85),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
