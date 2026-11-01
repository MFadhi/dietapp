import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'data/database/app_database.dart';
import 'data/services/food_database_seeder.dart';
import 'features/foods/application/food_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();
  try {
    final seeder = FoodDatabaseSeeder(database);
    await seeder.seedIfNeeded();
  } catch (_) {
    // If seeding fails, the app must still start.
  }

  // TODO(Phase 7): optional Firebase/Supabase init (sync is a placeholder; app works without a backend).
  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(database),
      ],
      child: const DietApp(),
    ),
  );
}
