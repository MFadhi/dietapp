import 'package:diet_app/domain/entities/food.dart';
import 'package:diet_app/domain/entities/nutrients.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Food', () {
    const testFood = Food(
      id: 1,
      seedKey: 'roti_test',
      nameEn: 'Roti',
      category: 'breads',
      diet: FoodDiet.vegan,
      nutrientsPer100g: Nutrients(
        kcal: 300,
        protein: 10,
        carbs: 60,
        fat: 4,
        fibre: 10,
      ),
      portions: [
        Portion(label: '1 roti', grams: 40, isDefault: true),
        Portion(label: '1 large roti', grams: 60, isDefault: false),
      ],
    );

    test('forGrams calculates correct scaled nutrients', () {
      final for40g = testFood.forGrams(40);
      expect(for40g.kcal, closeTo(120, 0.01));
      expect(for40g.protein, closeTo(4, 0.01));
      expect(for40g.carbs, closeTo(24, 0.01));
      expect(for40g.fat, closeTo(1.6, 0.01));
      expect(for40g.fibre, closeTo(4, 0.01));

      final for100g = testFood.forGrams(100);
      expect(for100g.kcal, 300);
      expect(for100g.protein, 10);
    });

    test('defaultPortion returns the portion marked as default', () {
      expect(testFood.defaultPortion.label, '1 roti');
      expect(testFood.defaultPortion.grams, 40);
      expect(testFood.defaultPortion.isDefault, true);
    });

    test('defaultPortion falls back to first portion if none marked default', () {
      const foodNoDefault = Food(
        id: 2,
        nameEn: 'Apple',
        category: 'fruits',
        diet: FoodDiet.vegan,
        nutrientsPer100g: Nutrients(kcal: 50, protein: 0.3, carbs: 12, fat: 0.2, fibre: 2.4),
        portions: [
          Portion(label: '1 medium', grams: 150, isDefault: false),
          Portion(label: '1 large', grams: 200, isDefault: false),
        ],
      );
      expect(foodNoDefault.defaultPortion.label, '1 medium');
      expect(foodNoDefault.defaultPortion.grams, 150);
    });

    test('defaultPortion falls back to synthetic g portion if portions list is empty', () {
      const foodEmptyPortions = Food(
        id: 3,
        nameEn: 'Sugar',
        category: 'staples',
        diet: FoodDiet.vegan,
        nutrientsPer100g: Nutrients(kcal: 400, protein: 0, carbs: 100, fat: 0, fibre: 0),
        portions: [],
      );
      expect(foodEmptyPortions.defaultPortion.label, 'g');
      expect(foodEmptyPortions.defaultPortion.grams, 1);
    });

    test('searchableTexts contains English name, regional names, and aliases', () {
      const foodWithAll = Food(
        id: 4,
        nameEn: 'Paneer',
        nameHi: 'पनीर',
        nameKn: 'ಪನೀರ್',
        aliases: ['panner', 'cottage cheese'],
        category: 'dairy',
        diet: FoodDiet.veg,
        nutrientsPer100g: Nutrients.zero,
      );
      final texts = foodWithAll.searchableTexts;
      expect(texts, contains('Paneer'));
      expect(texts, contains('पनीर'));
      expect(texts, contains('ಪನೀರ್'));
      expect(texts, contains('panner'));
      expect(texts, contains('cottage cheese'));
    });
  });
}
