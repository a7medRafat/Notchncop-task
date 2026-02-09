import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  print('TMDB_BEARER len = ${const String.fromEnvironment("TMDB_BEARER").length}');

  runApp(const TmdbApp());
}
