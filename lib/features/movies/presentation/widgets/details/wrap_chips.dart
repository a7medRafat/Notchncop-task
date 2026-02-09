import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_app/core/resources/AppColors.dart';
import 'package:tmdb_app/core/resources/app_text_styles.dart';
import 'package:tmdb_app/core/widgets/app_container.dart';

class WrapChips extends StatelessWidget {
  final List<String> items;

  const WrapChips({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: items
          .where((e) => e.trim().isNotEmpty)
          .map(
            (e) => AppContainer(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              borderRadius: BorderRadius.circular(999.r),
              color: AppColors.chipBackground,
              border: Border.all(color: AppColors.border),
              child: Text(
                e,
                style: AppTextStyles.w600(
                  fontSize: 10,
                  fontColor: AppColors.textSecondary,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
