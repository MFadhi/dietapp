import 'dart:convert';

import '../entities/food.dart';
import '../entities/nutrients.dart';

/// Seed food representation parsed directly from JSON without Flutter dependencies.
class SeedFoodItem {
  const SeedFoodItem({
    required this.key,
    required this.nameEn,
    this.nameHi,
    this.nameKn,
    this.aliases = const [],
    required this.category,
    required this.diet,
    required this.nutrientsPer100g,
    this.allergens = const [],
    this.tags = const [],
    required this.portions,
  });

  final String key;
  final String nameEn;
  final String? nameHi;
  final String? nameKn;
  final List<String> aliases;
  final String category;
  final FoodDiet diet;
  final Nutrients nutrientsPer100g;
  final List<String> allergens;
  final List<String> tags;
  final List<Portion> portions;

  factory SeedFoodItem.fromJson(Map<String, dynamic> json) {
    final key = json['key'] as String;
    final nameEn = json['nameEn'] as String;
    final nameHi = json['nameHi'] as String?;
    final nameKn = json['nameKn'] as String?;
    final aliases = ((json['aliases'] as List?) ?? const <dynamic>[])
        .map((e) => e.toString())
        .toList();
    final category = json['category'] as String? ?? 'staples';
    final dietStr = json['diet'] as String? ?? 'veg';
    final diet = FoodDiet.tryParse(dietStr) ?? FoodDiet.veg;

    final n = json['nutrientsPer100g'] as Map<String, dynamic>? ?? {};
    final nutrients = Nutrients(
      kcal: (n['kcal'] as num?)?.toDouble() ?? 0.0,
      protein: (n['protein'] as num?)?.toDouble() ?? 0.0,
      carbs: (n['carbs'] as num?)?.toDouble() ?? 0.0,
      fat: (n['fat'] as num?)?.toDouble() ?? 0.0,
      fibre: (n['fibre'] as num?)?.toDouble() ?? 0.0,
    );

    final allergens = ((json['allergens'] as List?) ?? const <dynamic>[])
        .map((e) => e.toString())
        .toList();
    final tags = ((json['tags'] as List?) ?? const <dynamic>[])
        .map((e) => e.toString())
        .toList();

    final rawPortions = (json['portions'] as List?) ?? const <dynamic>[];
    final portions = <Portion>[];
    var hasDefault = false;

    for (var i = 0; i < rawPortions.length; i++) {
      final p = rawPortions[i] as Map<String, dynamic>;
      final isDef = p['isDefault'] as bool? ?? (i == 0 && !hasDefault);
      if (isDef) hasDefault = true;
      portions.add(Portion(
        label: p['label'] as String? ?? '1 serving',
        grams: (p['grams'] as num?)?.toDouble() ?? 100.0,
        isDefault: isDef,
      ));
    }

    if (portions.isNotEmpty && !hasDefault) {
      portions[0] = Portion(
        label: portions[0].label,
        grams: portions[0].grams,
        isDefault: true,
      );
    }

    return SeedFoodItem(
      key: key,
      nameEn: nameEn,
      nameHi: nameHi,
      nameKn: nameKn,
      aliases: aliases,
      category: category,
      diet: diet,
      nutrientsPer100g: nutrients,
      allergens: allergens,
      tags: tags,
      portions: portions,
    );
  }
}

/// Parsed seed document.
class FoodSeedData {
  const FoodSeedData({
    required this.disclaimer,
    required this.foods,
  });

  final String disclaimer;
  final List<SeedFoodItem> foods;

  factory FoodSeedData.fromJson(Map<String, dynamic> json) {
    final disclaimer = json['disclaimer'] as String? ?? '';
    final foodsRaw = (json['foods'] as List?) ?? const <dynamic>[];
    final foods = foodsRaw
        .map((item) => SeedFoodItem.fromJson(item as Map<String, dynamic>))
        .toList();
    return FoodSeedData(disclaimer: disclaimer, foods: foods);
  }

  factory FoodSeedData.parseJsonString(String jsonString) {
    final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
    return FoodSeedData.fromJson(decoded);
  }
}
