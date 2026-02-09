import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/core/helpers/app_strings.dart';
import '../core/di/injection.dart';
import '../features/favorites/presentation/cubit/favorites_cubit.dart';
import 'router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TmdbApp extends StatelessWidget {
  const TmdbApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>().router;

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<FavoritesCubit>()..load()),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appTitle,
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.indigo,
            ),
            routerConfig: router,
          ),
        );
      },
    );
  }
}
