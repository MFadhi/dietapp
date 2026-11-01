import 'package:diet_app/domain/entities/food.dart';
import 'package:diet_app/domain/entities/nutrients.dart';
import 'package:diet_app/domain/services/food_searcher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FoodSearcher', () {
    const searcher = FoodSearcher();

    final testFoods = [
      const Food(
        id: 1,
        nameEn: 'Paneer',
        nameHi: 'पनीर',
        nameKn: 'ಪನೀರ್',
        aliases: ['cottage cheese'],
        category: 'dairy',
        diet: FoodDiet.veg,
        nutrientsPer100g: Nutrients.zero,
      ),
      const Food(
        id: 2,
        nameEn: 'Idli',
        nameHi: 'इडली',
        nameKn: 'ಇಡ್ಲಿ',
        aliases: ['steamed rice cake'],
        category: 'South Indian tiffin',
        diet: FoodDiet.vegan,
        nutrientsPer100g: Nutrients.zero,
      ),
      const Food(
        id: 3,
        nameEn: 'Chapati',
        nameHi: 'चपाती',
        nameKn: 'ಚಪಾತಿ',
        aliases: ['roti', 'phulka'],
        category: 'breads',
        diet: FoodDiet.vegan,
        nutrientsPer100g: Nutrients.zero,
      ),
      const Food(
        id: 4,
        nameEn: 'Masala Dosa',
        nameHi: 'मसाला डोसा',
        nameKn: 'ಮಸಾಲ ದೋಸೆ',
        aliases: ['masale dose', 'ದೋಸೆ'],
        category: 'South Indian tiffin',
        diet: FoodDiet.veg,
        nutrientsPer100g: Nutrients.zero,
      ),
      const Food(
        id: 5,
        nameEn: 'Rava Idli',
        nameHi: 'रवा इडली',
        nameKn: 'ರವೆ ಇಡ್ಲಿ',
        aliases: ['sooji idli'],
        category: 'South Indian tiffin',
        diet: FoodDiet.veg,
        nutrientsPer100g: Nutrients.zero,
      ),
    ];

    test('matches exact name with score 100', () {
      final results = searcher.search(testFoods, 'Paneer');
      expect(results.isNotEmpty, true);
      expect(results.first.food.nameEn, 'Paneer');
      expect(results.first.score, 100);
    });

    test('matches prefix with score 90', () {
      final results = searcher.search(testFoods, 'Pan');
      expect(results.isNotEmpty, true);
      expect(results.first.food.nameEn, 'Paneer');
      expect(results.first.score, 90);
    });

    test('matches typo "panner" against "Paneer" via Levenshtein', () {
      final results = searcher.search(testFoods, 'panner');
      expect(results.any((r) => r.food.nameEn == 'Paneer'), true);
      final match = results.firstWhere((r) => r.food.nameEn == 'Paneer');
      expect(match.score, greaterThanOrEqualTo(50));
    });

    test('matches typo "idly" against "Idli"', () {
      final results = searcher.search(testFoods, 'idly');
      expect(results.any((r) => r.food.nameEn == 'Idli'), true);
    });

    test('matches variant "chapathi" against "Chapati"', () {
      final results = searcher.search(testFoods, 'chapathi');
      expect(results.any((r) => r.food.nameEn == 'Chapati'), true);
    });

    test('matches regional Kannada script "ದೋಸೆ"', () {
      final results = searcher.search(testFoods, 'ದೋಸೆ');
      expect(results.any((r) => r.food.nameEn == 'Masala Dosa'), true);
    });

    test('matches aliases e.g. "roti" for "Chapati"', () {
      final results = searcher.search(testFoods, 'roti');
      expect(results.any((r) => r.food.nameEn == 'Chapati'), true);
    });

    test('prefers shorter English name on ties', () {
      // Both "Idli" and "Rava Idli" contain "idli".
      // "Idli" has score 100 (exact full-string match), while "Rava Idli" has score 80 (word-prefix).
      final results = searcher.search(testFoods, 'idli');
      expect(results.first.food.nameEn, 'Idli');
      expect(results[1].food.nameEn, 'Rava Idli');
    });

    test('respects maxResults limit of 50', () {
      final largeList = List.generate(
        80,
        (i) => Food(
          id: 100 + i,
          nameEn: 'Rice item $i',
          category: 'rice',
          diet: FoodDiet.vegan,
          nutrientsPer100g: Nutrients.zero,
        ),
      );
      final results = searcher.search(largeList, 'rice');
      expect(results.length, lessThanOrEqualTo(50));
    });

    test('empty query returns empty results', () {
      expect(searcher.search(testFoods, ''), isEmpty);
      expect(searcher.search(testFoods, '   '), isEmpty);
    });
  });
}
