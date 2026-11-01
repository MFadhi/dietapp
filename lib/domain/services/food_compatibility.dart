import '../entities/food.dart';
import '../entities/user_profile.dart';

/// A compatibility warning about a food for the current user.
class FoodWarning {
  const FoodWarning({required this.message, required this.kind});
  final String message;
  final WarningKind kind;
}

enum WarningKind { diet, allergen }

/// Checks food compatibility against a user's diet preferences and allergies.
/// Never hides food — only warns.
class FoodCompatibility {
  const FoodCompatibility();

  List<FoodWarning> check(Food food, UserProfile profile) {
    final warnings = <FoodWarning>[];

    // Diet mismatch warnings.
    final dietWarning = _checkDiet(food.diet, profile.dietType);
    if (dietWarning != null) warnings.add(dietWarning);

    // Allergen warnings (known allergen ids).
    for (final allergenId in food.allergenIds) {
      if (profile.allergies.contains(allergenId)) {
        warnings.add(FoodWarning(
          message: 'Contains ${_allergenLabel(allergenId)}',
          kind: WarningKind.allergen,
        ));
      }
    }

    // Custom allergies matched against food names (case-insensitive).
    final customAllergies = profile.allergies
        .where((a) => !_knownAllergenIds.contains(a))
        .toList();
    if (customAllergies.isNotEmpty) {
      final searchTexts = [
        food.nameEn.toLowerCase(),
        if (food.nameHi != null) food.nameHi!.toLowerCase(),
        if (food.nameKn != null) food.nameKn!.toLowerCase(),
        ...food.aliases.map((a) => a.toLowerCase()),
      ].join(' ');

      for (final custom in customAllergies) {
        if (searchTexts.contains(custom.toLowerCase())) {
          warnings.add(FoodWarning(
            message: 'May contain "$custom"',
            kind: WarningKind.allergen,
          ));
        }
      }
    }

    return warnings;
  }

  FoodWarning? _checkDiet(FoodDiet foodDiet, DietType userDiet) {
    switch (userDiet) {
      case DietType.vegan:
        if (foodDiet != FoodDiet.vegan) {
          return FoodWarning(
            message: 'Not vegan (${foodDiet.name})',
            kind: WarningKind.diet,
          );
        }
      case DietType.veg:
        if (foodDiet == FoodDiet.egg || foodDiet == FoodDiet.nonveg) {
          return FoodWarning(
            message: 'Not vegetarian (${foodDiet.name})',
            kind: WarningKind.diet,
          );
        }
      case DietType.eggetarian:
        if (foodDiet == FoodDiet.nonveg) {
          return const FoodWarning(
            message: 'Non-vegetarian',
            kind: WarningKind.diet,
          );
        }
      case DietType.nonVeg:
        // Non-veg eaters eat everything — no warnings.
        break;
    }
    return null;
  }

  static String _allergenLabel(String id) => switch (id) {
        'peanut' => 'peanuts',
        'tree_nut' => 'tree nuts',
        'milk' => 'dairy',
        'egg' => 'egg',
        'gluten' => 'gluten',
        'soy' => 'soy',
        'fish' => 'fish',
        'shellfish' => 'shellfish',
        'sesame' => 'sesame',
        'mustard' => 'mustard',
        _ => id,
      };

  static const _knownAllergenIds = {
    'peanut', 'tree_nut', 'milk', 'egg', 'gluten',
    'soy', 'fish', 'shellfish', 'sesame', 'mustard',
  };
}
