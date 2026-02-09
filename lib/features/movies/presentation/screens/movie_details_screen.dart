import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/core/di/injection.dart';
import 'package:tmdb_app/core/helpers/app_strings.dart';
import 'package:tmdb_app/core/widgets/app_error_view.dart';
import 'package:tmdb_app/core/widgets/loading_widget.dart';
import 'package:tmdb_app/features/movies/presentation/cubit/movie_details_cubit.dart';
import 'package:tmdb_app/features/movies/presentation/cubit/movie_details_state.dart';
import 'package:tmdb_app/features/movies/presentation/widgets/details/movie_details_body.dart';
import 'package:tmdb_app/features/movies/presentation/widgets/details/movie_details_hero_header.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MovieDetailsCubit>()..load(movieId),
      child: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return LoadingWidget();
          }

          if (state.error != null || state.details == null) {
            return Scaffold(
              body: AppErrorView(
                message: state.error ?? AppStrings.unknownError,
                onRetry: () => context.read<MovieDetailsCubit>().load(movieId),
              ),
            );
          }

          final d = state.details!;
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: MovieDetailsHeroHeader(details: d)),
                SliverToBoxAdapter(child: MovieDetailsBody(details: d)),
              ],
            ),
          );
        },
      ),
    );
  }
}
