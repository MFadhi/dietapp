/// Common allergens offered during onboarding (id -> display label).
/// Phase 2 food data should tag foods with these same ids.
class Allergens {
  Allergens._();

  static const Map<String, String> common = {
    'peanut': 'Peanuts',
    'tree_nut': 'Tree nuts',
    'milk': 'Milk / dairy',
    'egg': 'Eggs',
    'gluten': 'Gluten / wheat',
    'soy': 'Soy',
    'fish': 'Fish',
    'shellfish': 'Shellfish',
    'sesame': 'Sesame',
    'mustard': 'Mustard',
  };

  static String label(String id) {
    final known = common[id];
    if (known != null) return known;
    if (id.isEmpty) return id;
    return id[0].toUpperCase() + id.substring(1);
  }
}
