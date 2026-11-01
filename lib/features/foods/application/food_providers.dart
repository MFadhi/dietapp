import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/repositories/drift_food_log_repository.dart';
import '../../../data/repositories/drift_food_repository.dart';
import '../../../data/services/food_database_seeder.dart';
import '../../../domain/entities/food.dart';
import '../../../domain/entities/food_log_entry.dart';
import '../../../domain/entities/nutrients.dart';
import '../../../domain/repositories/food_log_repository.dart';
import '../../../domain/repositories/food_repository.dart';
import '../../../domain/services/food_compatibility.dart';
import '../../../domain/services/food_searcher.dart';

/// Database instance provider. Can be overridden in tests.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final foodDatabaseSeederProvider = Provider<FoodDatabaseSeeder>((ref) {
  return FoodDatabaseSeeder(ref.watch(databaseProvider));
});

final foodRepositoryProvider = Provider<FoodRepository>((ref) {
  return DriftFoodRepository(ref.watch(databaseProvider));
});

final foodLogRepositoryProvider = Provider<FoodLogRepository>((ref) {
  return DriftFoodLogRepository(ref.watch(databaseProvider));
});

final foodSearcherProvider = Provider<FoodSearcher>((ref) {
  return const FoodSearcher();
});

final foodCompatibilityProvider = Provider<FoodCompatibility>((ref) {
  return const FoodCompatibility();
});

/// All cached foods from the local database.
final allFoodsProvider = FutureProvider<List<Food>>((ref) async {
  final repo = ref.watch(foodRepositoryProvider);
  return repo.allFoods();
});

/// Single food by id.
final foodByIdProvider = FutureProvider.family<Food?, int>((ref, id) async {
  final repo = ref.watch(foodRepositoryProvider);
  return repo.byId(id);
});

/// Distinct recently logged foods, newest first.
final recentFoodsProvider = FutureProvider<List<Food>>((ref) async {
  final logRepo = ref.watch(foodLogRepositoryProvider);
  final foodRepo = ref.watch(foodRepositoryProvider);
  final ids = await logRepo.recentFoodIds(limit: 6);
  final foods = <Food>[];
  for (final id in ids) {
    final food = await foodRepo.byId(id);
    if (food != null) foods.add(food);
  }
  return foods;
});

/// Selected category filter in search.
final selectedCategoryProvider = StateProvider<String>((ref) => 'All');

/// Active search query.
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Filtered and searched foods.
final searchResultsProvider = Provider<AsyncValue<List<Food>>>((ref) {
  final allFoodsAsync = ref.watch(allFoodsProvider);
  final query = ref.watch(searchQueryProvider);
  final category = ref.watch(selectedCategoryProvider);
  final searcher = ref.watch(foodSearcherProvider);

  return allFoodsAsync.whenData((foods) {
    var filtered = foods;
    if (category != 'All') {
      filtered = filtered
          .where((f) => f.category.toLowerCase() == category.toLowerCase())
          .toList();
    }

    if (query.trim().isEmpty) {
      return filtered;
    }

    final searchResults = searcher.search(filtered, query);
    return searchResults.map((r) => r.food).toList();
  });
});

/// Stream of today's food log entries.
final todayFoodLogsProvider = StreamProvider<List<FoodLogEntry>>((ref) {
  final repo = ref.watch(foodLogRepositoryProvider);
  return repo.watchDay(DateTime.now());
});

/// Aggregated nutrients consumed today.
final todayNutrientsSummaryProvider = Provider<Nutrients>((ref) {
  final logs = ref.watch(todayFoodLogsProvider).value ?? const [];
  return Nutrients.sum(logs.map((e) => e.nutrients));
});
