import 'package:diet_app/domain/entities/nutrients.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Nutrients', () {
    test('zero constant has all 0 values', () {
      expect(Nutrients.zero.kcal, 0);
      expect(Nutrients.zero.protein, 0);
      expect(Nutrients.zero.carbs, 0);
      expect(Nutrients.zero.fat, 0);
      expect(Nutrients.zero.fibre, 0);
    });

    test('scale scales all macronutrients proportionally', () {
      const base = Nutrients(kcal: 100, protein: 10, carbs: 20, fat: 5, fibre: 2);
      final scaled = base.scale(2.5);

      expect(scaled.kcal, 250);
      expect(scaled.protein, 25);
      expect(scaled.carbs, 50);
      expect(scaled.fat, 12.5);
      expect(scaled.fibre, 5);
    });

    test('operator + adds nutrients correctly', () {
      const a = Nutrients(kcal: 100, protein: 10, carbs: 15, fat: 5, fibre: 2);
      const b = Nutrients(kcal: 50, protein: 2, carbs: 5, fat: 1, fibre: 1);
      final sum = a + b;

      expect(sum.kcal, 150);
      expect(sum.protein, 12);
      expect(sum.carbs, 20);
      expect(sum.fat, 6);
      expect(sum.fibre, 3);
    });

    test('Nutrients.sum sums an iterable of nutrients', () {
      final items = [
        const Nutrients(kcal: 100, protein: 5, carbs: 10, fat: 2, fibre: 1),
        const Nutrients(kcal: 200, protein: 15, carbs: 25, fat: 6, fibre: 3),
        const Nutrients(kcal: 50, protein: 1, carbs: 5, fat: 1, fibre: 0.5),
      ];
      final total = Nutrients.sum(items);

      expect(total.kcal, 350);
      expect(total.protein, 21);
      expect(total.carbs, 40);
      expect(total.fat, 9);
      expect(total.fibre, 4.5);
    });

    test('Nutrients.sum on empty list returns zero', () {
      expect(Nutrients.sum([]), Nutrients.zero);
    });
  });
}
