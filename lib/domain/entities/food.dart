import 'nutrients.dart';

/// Diet classification following Indian food labelling conventions.
enum FoodDiet {
  vegan,
  veg,
  egg,
  nonveg;

  static FoodDiet? tryParse(String? value) {
    if (value == null) return null;
    final lower = value.toLowerCase().trim();
    for (final d in values) {
      if (d.name == lower) return d;
    }
    return null;
  }
}

/// A household or standard portion.
class Portion {
  const Portion({
    required this.label,
    required this.grams,
    this.isDefault = false,
    this.id,
  });

  final int? id;
  final String label;
  final double grams;
  final bool isDefault;

  /// Synthetic portion for raw gram entry.
  static const g = Portion(label: 'g', grams: 1, isDefault: false);

  @override
  String toString() => 'Portion($label, ${grams}g${isDefault ? ', default' : ''})';
}

/// A food item from the database.
class Food {
  const Food({
    required this.id,
    this.seedKey,
    required this.nameEn,
    this.nameHi,
    this.nameKn,
    this.aliases = const [],
    required this.category,
    required this.diet,
    required this.nutrientsPer100g,
    this.allergenIds = const [],
    this.tags = const [],
    this.isSample = true,
    this.source = 'sample',
    this.barcode,
    this.portions = const [],
  });

  final int id;
  final String? seedKey;
  final String nameEn;
  final String? nameHi;
  final String? nameKn;
  final List<String> aliases;
  final String category;
  final FoodDiet diet;
  final Nutrients nutrientsPer100g;
  final List<String> allergenIds;
  final List<String> tags;
  final bool isSample;
  final String source;
  final String? barcode;
  final List<Portion> portions;

  /// Nutrients for a given gram weight.
  Nutrients forGrams(double grams) => nutrientsPer100g.scale(grams / 100);

  /// The default portion, or the synthetic "g" if none is marked default.
  Portion get defaultPortion {
    for (final p in portions) {
      if (p.isDefault) return p;
    }
    return portions.isNotEmpty ? portions.first : Portion.g;
  }

  /// All searchable text fragments (for FoodSearcher).
  List<String> get searchableTexts => [
        nameEn,
        if (nameHi != null) nameHi!,
        if (nameKn != null) nameKn!,
        ...aliases,
      ];
}
