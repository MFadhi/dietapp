import 'package:diet_app/domain/entities/food.dart';
import 'package:diet_app/domain/entities/nutrients.dart';
import 'package:diet_app/domain/entities/user_profile.dart';
import 'package:diet_app/domain/services/food_compatibility.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FoodCompatibility', () {
    const compatibility = FoodCompatibility();

    UserProfile createProfile({
      DietType diet = DietType.veg,
      List<String> allergies = const [],
    }) {
      return UserProfile(
        name: 'Test',
        age: 25,
        gender: Gender.male,
        heightCm: 175,
        weightKg: 70,
        activityLevel: ActivityLevel.moderate,
        dietType: diet,
        allergies: allergies,
        goal: Goal.maintain,
      );
    }

    const veganFood = Food(
      id: 1,
      nameEn: 'Plain Rice',
      category: 'grains',
      diet: FoodDiet.vegan,
      nutrientsPer100g: Nutrients.zero,
    );

    const vegDairyFood = Food(
      id: 2,
      nameEn: 'Paneer Butter Masala',
      category: 'curry',
      diet: FoodDiet.veg,
      allergenIds: ['milk'],
      nutrientsPer100g: Nutrients.zero,
    );

    const eggFood = Food(
      id: 3,
      nameEn: 'Egg Bhurji',
      category: 'egg',
      diet: FoodDiet.egg,
      allergenIds: ['egg'],
      nutrientsPer100g: Nutrients.zero,
    );

    const nonVegFood = Food(
      id: 4,
      nameEn: 'Chicken Curry',
      category: 'chicken',
      diet: FoodDiet.nonveg,
      nutrientsPer100g: Nutrients.zero,
    );

    test('vegan user gets warnings on veg (dairy), egg, and non-veg foods', () {
      final profile = createProfile(diet: DietType.vegan);

      expect(compatibility.check(veganFood, profile), isEmpty);

      final vegWarnings = compatibility.check(vegDairyFood, profile);
      expect(vegWarnings.any((w) => w.kind == WarningKind.diet), true);

      final eggWarnings = compatibility.check(eggFood, profile);
      expect(eggWarnings.any((w) => w.kind == WarningKind.diet), true);

      final nonVegWarnings = compatibility.check(nonVegFood, profile);
      expect(nonVegWarnings.any((w) => w.kind == WarningKind.diet), true);
    });

    test('vegetarian user gets warnings on egg and non-veg, but not on veg or vegan', () {
      final profile = createProfile(diet: DietType.veg);

      expect(compatibility.check(veganFood, profile), isEmpty);
      expect(compatibility.check(vegDairyFood, profile), isEmpty);

      final eggWarnings = compatibility.check(eggFood, profile);
      expect(eggWarnings.any((w) => w.kind == WarningKind.diet), true);

      final nonVegWarnings = compatibility.check(nonVegFood, profile);
      expect(nonVegWarnings.any((w) => w.kind == WarningKind.diet), true);
    });

    test('eggetarian user gets warning on non-veg, but not on egg, veg, or vegan', () {
      final profile = createProfile(diet: DietType.eggetarian);

      expect(compatibility.check(veganFood, profile), isEmpty);
      expect(compatibility.check(vegDairyFood, profile), isEmpty);
      expect(compatibility.check(eggFood, profile), isEmpty);

      final nonVegWarnings = compatibility.check(nonVegFood, profile);
      expect(nonVegWarnings.any((w) => w.kind == WarningKind.diet), true);
    });

    test('non-vegetarian user gets no diet mismatch warnings', () {
      final profile = createProfile(diet: DietType.nonVeg);

      expect(compatibility.check(veganFood, profile), isEmpty);
      expect(compatibility.check(vegDairyFood, profile), isEmpty);
      expect(compatibility.check(eggFood, profile), isEmpty);
      expect(compatibility.check(nonVegFood, profile), isEmpty);
    });

    test('warns when user is allergic to food allergen id', () {
      final profile = createProfile(allergies: ['milk', 'gluten']);

      final warnings = compatibility.check(vegDairyFood, profile);
      expect(warnings.any((w) => w.kind == WarningKind.allergen && w.message.contains('dairy')), true);
    });

    test('warns on custom allergy matched against food name or aliases', () {
      final profile = createProfile(allergies: ['mushroom']);

      const mushroomFood = Food(
        id: 5,
        nameEn: 'Mushroom Masala',
        aliases: ['kalan curry'],
        category: 'vegetables',
        diet: FoodDiet.veg,
        nutrientsPer100g: Nutrients.zero,
      );

      final warnings = compatibility.check(mushroomFood, profile);
      expect(warnings.any((w) => w.kind == WarningKind.allergen && w.message.contains('mushroom')), true);
    });
  });
}
