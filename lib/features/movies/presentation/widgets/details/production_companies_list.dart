import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_app/core/functions/app_functions.dart';
import 'package:tmdb_app/core/resources/AppColors.dart';
import 'package:tmdb_app/core/resources/app_text_styles.dart';
import 'package:tmdb_app/core/widgets/app_container.dart';
import 'package:tmdb_app/features/movies/data/models/production_company.dart';

class ProductionCompaniesList extends StatelessWidget {
  final List<ProductionCompany> companies;

  const ProductionCompaniesList({super.key, required this.companies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: companies.length,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (_, i) => _CompanyChip(company: companies[i]),
      ),
    );
  }
}

class _CompanyChip extends StatelessWidget {
  final ProductionCompany company;

  const _CompanyChip({required this.company});

  @override
  Widget build(BuildContext context) {
    final logoUrl = AppFunctions.logoUrl(company.logoPath, size: 'w92');

    return AppContainer(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      borderRadius: BorderRadius.circular(14.r),
      border: Border.all(color: AppColors.border),
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CompanyLogo(logoUrl: logoUrl),
          SizedBox(width: 10.w),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 150.w),
            child: Text(
              company.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.w600(
                fontColor: AppColors.textSecondary,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompanyLogo extends StatelessWidget {
  final String? logoUrl;

  const _CompanyLogo({required this.logoUrl});

  @override
  Widget build(BuildContext context) {
    if (logoUrl == null) {
      return Container(
        width: 34.w,
        height: 34.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.border,
        ),
        child: Icon(Icons.business, size: 18.sp, color: Colors.grey.shade700),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: 34.w,
        height: 34.w,
        color: Colors.white,
        child: Image.network(
          logoUrl!,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) =>
              Icon(Icons.business, size: 18.sp, color: Colors.grey.shade700),
        ),
      ),
    );
  }
}
