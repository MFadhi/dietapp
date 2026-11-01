
import '../../domain/entities/food.dart';
import '../../domain/entities/nutrients.dart';
import '../../domain/repositories/food_repository.dart';
import '../database/app_database.dart';

/// Drift-backed implementation of [FoodRepository] with in-memory caching.
class DriftFoodRepository implements FoodRepository {
  DriftFoodRepository(this._db);

  final AppDatabase _db;
  List<Food>? _cache;

  void invalidateCache() {
    _cache = null;
  }

  @override
  Future<List<Food>> allFoods() async {
    if (_cache != null) return _cache!;

    final foodRows = await _db.select(_db.foods).get();
    final portionRows = await _db.select(_db.portions).get();

    // Group portions by foodId
    final portionsByFood = <int, List<Portion>>{};
    for (final p in portionRows) {
      final list = portionsByFood.putIfAbsent(p.foodId, () => []);
      list.add(Portion(
        id: p.id,
        label: p.label,
        grams: p.grams,
        isDefault: p.isDefault,
      ));
    }

    final foods = foodRows.map((row) {
      final portions = portionsByFood[row.id] ?? const [];
      return Food(
        id: row.id,
        seedKey: row.seedKey,
        nameEn: row.nameEn,
        nameHi: row.nameHi,
        nameKn: row.nameKn,
        aliases: row.aliases.isEmpty ? const [] : row.aliases.split('|'),
        category: row.category,
        diet: FoodDiet.tryParse(row.diet) ?? FoodDiet.veg,
        nutrientsPer100g: Nutrients(
          kcal: row.kcalPer100,
          protein: row.proteinPer100,
          carbs: row.carbsPer100,
          fat: row.fatPer100,
          fibre: row.fibrePer100,
        ),
        allergenIds: row.allergens.isEmpty
            ? const []
            : row.allergens
                .split(',')
                .where((a) => a.isNotEmpty)
                .toList(),
        tags: row.tags.isEmpty
            ? const []
            : row.tags
                .split(',')
                .where((t) => t.isNotEmpty)
                .toList(),
        isSample: row.isSample,
        source: row.source,
        barcode: row.barcode,
        portions: portions,
      );
    }).toList();

    _cache = foods;
    return foods;
  }

  @override
  Future<Food?> byId(int id) async {
    if (_cache != null) {
      for (final f in _cache!) {
        if (f.id == id) return f;
      }
    }

    final foodRow = await (_db.select(_db.foods)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (foodRow == null) return null;

    final portionRows = await (_db.select(_db.portions)
          ..where((t) => t.foodId.equals(id)))
        .get();

    final portions = portionRows
        .map((p) => Portion(
              id: p.id,
              label: p.label,
              grams: p.grams,
              isDefault: p.isDefault,
            ))
        .toList();

    return Food(
      id: foodRow.id,
      seedKey: foodRow.seedKey,
      nameEn: foodRow.nameEn,
      nameHi: foodRow.nameHi,
      nameKn: foodRow.nameKn,
      aliases: foodRow.aliases.isEmpty ? const [] : foodRow.aliases.split('|'),
      category: foodRow.category,
      diet: FoodDiet.tryParse(foodRow.diet) ?? FoodDiet.veg,
      nutrientsPer100g: Nutrients(
        kcal: foodRow.kcalPer100,
        protein: foodRow.proteinPer100,
        carbs: foodRow.carbsPer100,
        fat: foodRow.fatPer100,
        fibre: foodRow.fibrePer100,
      ),
      allergenIds: foodRow.allergens.isEmpty
          ? const []
          : foodRow.allergens.split(',').where((a) => a.isNotEmpty).toList(),
      tags: foodRow.tags.isEmpty
          ? const []
          : foodRow.tags.split(',').where((t) => t.isNotEmpty).toList(),
      isSample: foodRow.isSample,
      source: foodRow.source,
      barcode: foodRow.barcode,
      portions: portions,
    );
  }
}
