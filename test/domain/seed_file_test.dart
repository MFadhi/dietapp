import 'dart:io';
import 'package:diet_app/domain/entities/food.dart';
import 'package:diet_app/domain/services/food_seed_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Seed File Validation (foods_seed.json)', () {
    late String jsonContent;
    late FoodSeedData seedData;

    setUpAll(() {
      final file = File('assets/data/foods_seed.json');
      expect(file.existsSync(), true, reason: 'assets/data/foods_seed.json must exist');
      jsonContent = file.readAsStringSync();
      seedData = FoodSeedData.parseJsonString(jsonContent);
    });

    test('top-level disclaimer states values are SAMPLE DATA and references IFCT 2017', () {
      expect(seedData.disclaimer, isNotEmpty);
      expect(seedData.disclaimer, contains('SAMPLE DATA'));
      expect(seedData.disclaimer, contains('IFCT 2017'));
    });

    test('contains at least 100 foods', () {
      expect(seedData.foods.length, greaterThanOrEqualTo(100));
    });

    test('all food keys are non-empty and unique', () {
      final seenKeys = <String>{};
      for (final food in seedData.foods) {
        expect(food.key, isNotEmpty, reason: 'Food key cannot be empty');
        expect(
          seenKeys.add(food.key),
          true,
          reason: 'Duplicate food key: ${food.key}',
        );
      }
    });

    test('every food has at least 1 portion and exactly one default portion', () {
      for (final food in seedData.foods) {
        expect(
          food.portions,
          isNotEmpty,
          reason: '${food.nameEn} must have at least one portion',
        );
        final defaultCount = food.portions.where((p) => p.isDefault).length;
        expect(
          defaultCount,
          1,
          reason: '${food.nameEn} must have exactly one default portion (found $defaultCount)',
        );
      }
    });

    test('all foods have a valid diet enum', () {
      for (final food in seedData.foods) {
        expect(
          FoodDiet.values.contains(food.diet),
          true,
          reason: '${food.nameEn} has invalid diet ${food.diet}',
        );
      }
    });

    test('energy roughly matches macros (4p + 4c + 9f)', () {
      for (final food in seedData.foods) {
        final n = food.nutrientsPer100g;
        final expectedKcal = n.protein * 4.0 + n.carbs * 4.0 + n.fat * 9.0;
        final diff = (n.kcal - expectedKcal).abs();

        // Kcal should roughly match 4p + 4c + 9f within 5 kcal or rounding tolerance
        expect(
          diff,
          lessThanOrEqualTo(5.0),
          reason: '${food.nameEn} (${food.key}) kcal (${n.kcal}) differs from 4p+4c+9f ($expectedKcal)',
        );
      }
    });
  });
}
