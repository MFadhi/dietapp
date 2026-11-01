import 'package:drift/drift.dart';

import '../../domain/entities/food_log_entry.dart';
import '../../domain/entities/meal_type.dart';
import '../../domain/entities/nutrients.dart';
import '../../domain/repositories/food_log_repository.dart';
import '../database/app_database.dart';

/// Drift-backed implementation of [FoodLogRepository].
class DriftFoodLogRepository implements FoodLogRepository {
  DriftFoodLogRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<FoodLogEntry>> watchDay(DateTime day) {
    final local = day.toLocal();
    final startOfDay = DateTime(local.year, local.month, local.day);
    final endOfDay = DateTime(local.year, local.month, local.day, 23, 59, 59, 999);

    final query = _db.select(_db.foodLogEntries)
      ..where((t) => t.loggedAt.isBiggerOrEqualValue(startOfDay) & t.loggedAt.isSmallerOrEqualValue(endOfDay))
      ..orderBy([(t) => OrderingTerm.asc(t.loggedAt)]);

    return query.watch().map((rows) => rows.map(_fromRow).toList());
  }

  @override
  Future<int> add(FoodLogEntry entry) async {
    return _db.into(_db.foodLogEntries).insert(
          FoodLogEntriesCompanion.insert(
            foodId: Value(entry.foodId),
            foodName: entry.foodName,
            meal: entry.meal.name,
            loggedAt: entry.loggedAt,
            quantity: entry.quantity,
            portionLabel: entry.portionLabel,
            portionGrams: entry.portionGrams,
            kcal: entry.nutrients.kcal,
            proteinG: entry.nutrients.protein,
            carbsG: entry.nutrients.carbs,
            fatG: entry.nutrients.fat,
            fibreG: entry.nutrients.fibre,
          ),
        );
  }

  @override
  Future<void> update(FoodLogEntry entry) async {
    if (entry.id == null) {
      throw ArgumentError('Cannot update a FoodLogEntry without an id');
    }
    await (_db.update(_db.foodLogEntries)..where((t) => t.id.equals(entry.id!))).write(
      FoodLogEntriesCompanion(
        foodId: Value(entry.foodId),
        foodName: Value(entry.foodName),
        meal: Value(entry.meal.name),
        loggedAt: Value(entry.loggedAt),
        quantity: Value(entry.quantity),
        portionLabel: Value(entry.portionLabel),
        portionGrams: Value(entry.portionGrams),
        kcal: Value(entry.nutrients.kcal),
        proteinG: Value(entry.nutrients.protein),
        carbsG: Value(entry.nutrients.carbs),
        fatG: Value(entry.nutrients.fat),
        fibreG: Value(entry.nutrients.fibre),
      ),
    );
  }

  @override
  Future<void> delete(int id) async {
    await (_db.delete(_db.foodLogEntries)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<List<int>> recentFoodIds({int limit = 10}) async {
    final query = _db.select(_db.foodLogEntries)
      ..where((t) => t.foodId.isNotNull())
      ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)])
      ..limit(limit * 3); // Fetch more to ensure we get distinct ids

    final rows = await query.get();
    final distinctIds = <int>[];
    for (final r in rows) {
      if (r.foodId != null && !distinctIds.contains(r.foodId!)) {
        distinctIds.add(r.foodId!);
        if (distinctIds.length >= limit) break;
      }
    }
    return distinctIds;
  }

  @override
  Future<void> deleteAll() async {
    await _db.delete(_db.foodLogEntries).go();
  }

  FoodLogEntry _fromRow(FoodLogRow row) {
    return FoodLogEntry(
      id: row.id,
      foodId: row.foodId,
      foodName: row.foodName,
      meal: MealType.tryParse(row.meal) ?? MealType.snack,
      loggedAt: row.loggedAt,
      quantity: row.quantity,
      portionLabel: row.portionLabel,
      portionGrams: row.portionGrams,
      nutrients: Nutrients(
        kcal: row.kcal,
        protein: row.proteinG,
        carbs: row.carbsG,
        fat: row.fatG,
        fibre: row.fibreG,
      ),
    );
  }
}
