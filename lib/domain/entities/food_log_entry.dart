import 'food.dart';
import 'meal_type.dart';
import 'nutrients.dart';

/// An immutable snapshot of a food log entry. Nutrients are stored at logging
/// time so the log stays valid even if the food database changes.
class FoodLogEntry {
  const FoodLogEntry({
    this.id,
    this.foodId,
    required this.foodName,
    required this.meal,
    required this.loggedAt,
    required this.quantity,
    required this.portionLabel,
    required this.portionGrams,
    required this.nutrients,
  });

  final int? id;
  final int? foodId;
  final String foodName;
  final MealType meal;
  final DateTime loggedAt;
  final double quantity;
  final String portionLabel;
  final double portionGrams;

  /// Snapshot nutrients (already scaled to quantity × portion).
  final Nutrients nutrients;

  /// Create a log entry from a [Food], [Portion], quantity and meal.
  factory FoodLogEntry.fromFood({
    required Food food,
    required Portion portion,
    required double quantity,
    required MealType meal,
    DateTime? loggedAt,
  }) {
    final grams = portion.grams * quantity;
    final scaled = food.forGrams(grams);
    return FoodLogEntry(
      foodId: food.id,
      foodName: food.nameEn,
      meal: meal,
      loggedAt: loggedAt ?? DateTime.now(),
      quantity: quantity,
      portionLabel: portion.label,
      portionGrams: portion.grams,
      nutrients: scaled,
    );
  }

  /// Return a copy with updated quantity, re-scaling nutrients proportionally.
  FoodLogEntry withQuantity(double newQuantity) {
    if (newQuantity == quantity) return this;
    final factor = newQuantity / quantity;
    return FoodLogEntry(
      id: id,
      foodId: foodId,
      foodName: foodName,
      meal: meal,
      loggedAt: loggedAt,
      quantity: newQuantity,
      portionLabel: portionLabel,
      portionGrams: portionGrams,
      nutrients: nutrients.scale(factor),
    );
  }

  /// Return a copy with a different meal.
  FoodLogEntry withMeal(MealType newMeal) {
    if (newMeal == meal) return this;
    return FoodLogEntry(
      id: id,
      foodId: foodId,
      foodName: foodName,
      meal: newMeal,
      loggedAt: loggedAt,
      quantity: quantity,
      portionLabel: portionLabel,
      portionGrams: portionGrams,
      nutrients: nutrients,
    );
  }

  /// Strip the id (for undo / re-insert).
  FoodLogEntry withoutId() => FoodLogEntry(
        foodId: foodId,
        foodName: foodName,
        meal: meal,
        loggedAt: loggedAt,
        quantity: quantity,
        portionLabel: portionLabel,
        portionGrams: portionGrams,
        nutrients: nutrients,
      );
}
