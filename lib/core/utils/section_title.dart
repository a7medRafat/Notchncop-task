import 'package:flutter/material.dart';
import 'package:tmdb_app/core/resources/AppColors.dart';
import 'package:tmdb_app/core/resources/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.w600(fontSize: 12, fontColor: AppColors.primary),
    );
  }
}
