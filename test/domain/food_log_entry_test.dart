import 'package:diet_app/domain/entities/food.dart';
import 'package:diet_app/domain/entities/food_log_entry.dart';
import 'package:diet_app/domain/entities/meal_type.dart';
import 'package:diet_app/domain/entities/nutrients.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FoodLogEntry', () {
    const testFood = Food(
      id: 10,
      nameEn: 'Idli',
      category: 'South Indian tiffin',
      diet: FoodDiet.vegan,
      nutrientsPer100g: Nutrients(
        kcal: 140,
        protein: 5,
        carbs: 28,
        fat: 0.5,
        fibre: 2,
      ),
      portions: [
        Portion(label: '1 idli', grams: 40, isDefault: true),
      ],
    );

    test('fromFood creates entry with correct snapshot nutrients', () {
      final now = DateTime(2026, 3, 1, 8, 30);
      final entry = FoodLogEntry.fromFood(
        food: testFood,
        portion: testFood.defaultPortion,
        quantity: 2.0,
        meal: MealType.breakfast,
        loggedAt: now,
      );

      expect(entry.foodId, 10);
      expect(entry.foodName, 'Idli');
      expect(entry.meal, MealType.breakfast);
      expect(entry.loggedAt, now);
      expect(entry.quantity, 2.0);
      expect(entry.portionLabel, '1 idli');
      expect(entry.portionGrams, 40);

      // Total grams = 2 * 40 = 80g.
      // Nutrients: 80g / 100g = 0.8 factor.
      expect(entry.nutrients.kcal, closeTo(112, 0.01));
      expect(entry.nutrients.protein, closeTo(4.0, 0.01));
      expect(entry.nutrients.carbs, closeTo(22.4, 0.01));
      expect(entry.nutrients.fat, closeTo(0.4, 0.01));
      expect(entry.nutrients.fibre, closeTo(1.6, 0.01));
    });

    test('fromFood supports direct grams entry with Portion.g', () {
      final entry = FoodLogEntry.fromFood(
        food: testFood,
        portion: Portion.g,
        quantity: 150.0,
        meal: MealType.lunch,
      );

      expect(entry.portionLabel, 'g');
      expect(entry.portionGrams, 1.0);
      expect(entry.quantity, 150.0);
      // 150g -> 1.5x of per100g
      expect(entry.nutrients.kcal, closeTo(210, 0.01));
      expect(entry.nutrients.protein, closeTo(7.5, 0.01));
    });

    test('withQuantity scales nutrients proportionally', () {
      final entry = FoodLogEntry.fromFood(
        food: testFood,
        portion: testFood.defaultPortion,
        quantity: 1.0, // 40g = 56 kcal
        meal: MealType.breakfast,
      );

      expect(entry.nutrients.kcal, closeTo(56, 0.01));

      final doubled = entry.withQuantity(2.0);
      expect(doubled.quantity, 2.0);
      expect(doubled.nutrients.kcal, closeTo(112, 0.01));
      expect(doubled.nutrients.protein, closeTo(4.0, 0.01));

      final halved = entry.withQuantity(0.5);
      expect(halved.quantity, 0.5);
      expect(halved.nutrients.kcal, closeTo(28, 0.01));
    });

    test('withMeal updates meal without changing nutrients', () {
      final entry = FoodLogEntry.fromFood(
        food: testFood,
        portion: testFood.defaultPortion,
        quantity: 1.0,
        meal: MealType.breakfast,
      );

      final lunchEntry = entry.withMeal(MealType.lunch);
      expect(lunchEntry.meal, MealType.lunch);
      expect(lunchEntry.nutrients.kcal, entry.nutrients.kcal);
      expect(lunchEntry.foodName, entry.foodName);
    });

    test('withoutId strips id for undo re-insertion', () {
      final entry = FoodLogEntry(
        id: 99,
        foodId: 10,
        foodName: 'Idli',
        meal: MealType.breakfast,
        loggedAt: DateTime.now(),
        quantity: 1,
        portionLabel: '1 idli',
        portionGrams: 40,
        nutrients: const Nutrients(kcal: 56, protein: 2, carbs: 11, fat: 0.2, fibre: 0.8),
      );

      final withoutId = entry.withoutId();
      expect(withoutId.id, isNull);
      expect(withoutId.foodId, 10);
      expect(withoutId.foodName, 'Idli');
      expect(withoutId.nutrients.kcal, 56);
    });
  });
}
