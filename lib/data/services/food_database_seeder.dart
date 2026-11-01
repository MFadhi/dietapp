import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../../domain/services/food_seed_parser.dart';
import '../database/app_database.dart';

/// Seeds the drift database with initial Indian food data from assets/data/foods_seed.json.
class FoodDatabaseSeeder {
  FoodDatabaseSeeder(this._db);

  final AppDatabase _db;
  static const assetPath = 'assets/data/foods_seed.json';

  /// Seed the database if the foods table is empty.
  /// If seeding fails, does not throw so the app can still start.
  Future<bool> seedIfNeeded({String? seedJson}) async {
    try {
      final count = await _db.foods.count().getSingle();
      if (count > 0) {
        return true; // Already seeded
      }
      return await forceSeed(seedJson: seedJson);
    } catch (e) {
      // Graceful degradation: app must still start if seeding fails.
      return false;
    }
  }

  /// Force seed (or re-seed) the foods table. Used for retry buttons.
  Future<bool> forceSeed({String? seedJson}) async {
    try {
      final raw = seedJson ?? await rootBundle.loadString(assetPath);
      final seedData = FoodSeedData.parseJsonString(raw);

      await _db.transaction(() async {
        for (final item in seedData.foods) {
          final foodId = await _db.into(_db.foods).insert(
                FoodsCompanion.insert(
                  seedKey: Value(item.key),
                  nameEn: item.nameEn,
                  nameHi: Value(item.nameHi),
                  nameKn: Value(item.nameKn),
                  aliases: item.aliases.join('|'),
                  category: item.category,
                  diet: item.diet.name,
                  kcalPer100: item.nutrientsPer100g.kcal,
                  proteinPer100: item.nutrientsPer100g.protein,
                  carbsPer100: item.nutrientsPer100g.carbs,
                  fatPer100: item.nutrientsPer100g.fat,
                  fibrePer100: item.nutrientsPer100g.fibre,
                  allergens: item.allergens.join(','),
                  tags: item.tags.join(','),
                  isSample: const Value(true),
                  source: const Value('sample'),
                ),
              );

          for (final portion in item.portions) {
            await _db.into(_db.portions).insert(
                  PortionsCompanion.insert(
                    foodId: foodId,
                    label: portion.label,
                    grams: portion.grams,
                    isDefault: Value(portion.isDefault),
                  ),
                );
          }
        }
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
