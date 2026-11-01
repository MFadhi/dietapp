import '../entities/food.dart';

/// Read-only food repository (backed by the local database).
abstract interface class FoodRepository {
  /// All foods, cached in memory after first call.
  Future<List<Food>> allFoods();

  /// Single food by primary key. Returns null when not found.
  Future<Food?> byId(int id);
}
