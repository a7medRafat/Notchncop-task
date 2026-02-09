import 'package:flutter/material.dart';
import 'package:tmdb_app/core/helpers/app_strings.dart';
import 'package:tmdb_app/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:tmdb_app/features/movies/presentation/screens/popular_movies_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _index = 0;

  final _tabs = const [
    _Tab(
      title: AppStrings.popularMovies,
      icon: Icons.local_fire_department_outlined,
      child: PopularMoviesScreen(),
    ),
    _Tab(
      title: AppStrings.favoritesMovies,
      icon: Icons.favorite_border,
      child: FavoritesScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final tab = _tabs[_index];

    return Scaffold(
      appBar: AppBar(title: Text(tab.title)),
      body: tab.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: _tabs
            .map(
              (t) => NavigationDestination(icon: Icon(t.icon), label: t.title),
            )
            .toList(),
      ),
    );
  }
}

class _Tab {
  final String title;
  final IconData icon;
  final Widget child;

  const _Tab({required this.title, required this.icon, required this.child});
}
