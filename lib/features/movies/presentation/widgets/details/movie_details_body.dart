import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_app/core/helpers/app_strings.dart';
import 'package:tmdb_app/core/helpers/spacing.dart';
import 'package:tmdb_app/core/resources/AppColors.dart';
import 'package:tmdb_app/core/resources/app_text_styles.dart';
import 'package:tmdb_app/core/utils/section_title.dart';
import 'package:tmdb_app/features/movies/domain/entities/movie_details.dart';
import 'package:tmdb_app/features/movies/presentation/widgets/details/movie_stats_row.dart';
import 'package:tmdb_app/features/movies/presentation/widgets/details/production_companies_list.dart';
import 'package:tmdb_app/features/movies/presentation/widgets/details/wrap_chips.dart';

class MovieDetailsBody extends StatelessWidget {
  final MovieDetails details;

  const MovieDetailsBody({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final overview =
        (details.overview == null || details.overview!.trim().isEmpty)
        ? AppStrings.noOverview
        : details.overview!.trim();

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieStatsRow(
            voteAverage: details.voteAverage,
            voteCount: details.voteCount,
            revenue: details.revenue,
          ),

          verticalSpace(18),

          SectionTitle(AppStrings.overview),
          verticalSpace(8),
          Text(
            overview,
            style: AppTextStyles.w500(
              fontSize: 11,
              fontColor: AppColors.textSecondary,
            ),
          ),

          verticalSpace(22),

          if (details.spokenLanguages.isNotEmpty) ...[
            SectionTitle(AppStrings.spokenLanguages),
            verticalSpace(10),
            WrapChips(items: details.spokenLanguages),
            verticalSpace(22),
          ],

          if (details.productionCountries.isNotEmpty) ...[
            SectionTitle(AppStrings.productionCountries),
            verticalSpace(10),
            WrapChips(items: details.productionCountries),
            verticalSpace(22),
          ],

          if (details.productionCompanies.isNotEmpty) ...[
            SectionTitle(AppStrings.productionCompanies),
            verticalSpace(10),
            ProductionCompaniesList(companies: details.productionCompanies),
          ],
        ],
      ),
    );
  }
}
