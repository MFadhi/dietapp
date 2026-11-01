import '../entities/food_log_entry.dart';

/// CRUD for the daily food log.
abstract interface class FoodLogRepository {
  /// Watch all entries for a calendar day (local timezone).
  Stream<List<FoodLogEntry>> watchDay(DateTime day);

  /// Insert a new entry, returning its id.
  Future<int> add(FoodLogEntry entry);

  /// Update an existing entry (must have an id).
  Future<void> update(FoodLogEntry entry);

  /// Delete an entry by id.
  Future<void> delete(int id);

  /// Distinct food ids from recent entries, newest first.
  Future<List<int>> recentFoodIds({int limit = 10});

  /// Delete all log entries (used in "Delete all data").
  Future<void> deleteAll();
}
