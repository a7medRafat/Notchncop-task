import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_app/core/functions/app_functions.dart';
import 'package:tmdb_app/core/helpers/app_strings.dart';
import 'package:tmdb_app/core/helpers/spacing.dart';
import 'package:tmdb_app/core/resources/AppColors.dart';
import 'package:tmdb_app/core/resources/app_text_styles.dart';
import 'package:tmdb_app/core/widgets/app_container.dart';

class MovieStatsRow extends StatelessWidget {
  final double? voteAverage;
  final int? voteCount;
  final int? revenue;

  const MovieStatsRow({
    super.key,
    required this.voteAverage,
    required this.voteCount,
    required this.revenue,
  });

  @override
  Widget build(BuildContext context) {
    final rating = voteAverage == null ? '—' : voteAverage!.toStringAsFixed(1);
    final votes = voteCount == null
        ? '—'
        : AppFunctions.formatCompact(voteCount!);
    final rev = (revenue == null || revenue == 0)
        ? '—'
        : AppFunctions.formatMoney(revenue!);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _StatTile(
            icon: Icons.star_rounded,
            label: AppStrings.rating,
            value: rating,
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: _StatTile(
            icon: Icons.people_alt_rounded,
            label: AppStrings.votes,
            value: votes,
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: _StatTile(
            icon: Icons.monetization_on_rounded,
            label: AppStrings.revenue,
            value: rev,
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      borderRadius: BorderRadius.circular(14.r),
      border: Border.all(color: AppColors.border),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 16.sp),
            horizontalSpace(4),
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.w600(
                  fontSize: 11,
                  fontColor: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
