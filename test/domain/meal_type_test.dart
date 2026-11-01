import 'package:diet_app/domain/entities/meal_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MealType', () {
    test('forTime returns breakfast before 11:00', () {
      expect(MealType.forTime(DateTime(2026, 1, 1, 7, 30)), MealType.breakfast);
      expect(MealType.forTime(DateTime(2026, 1, 1, 10, 59)), MealType.breakfast);
    });

    test('forTime returns lunch between 11:00 and 15:00', () {
      expect(MealType.forTime(DateTime(2026, 1, 1, 11, 0)), MealType.lunch);
      expect(MealType.forTime(DateTime(2026, 1, 1, 13, 0)), MealType.lunch);
      expect(MealType.forTime(DateTime(2026, 1, 1, 14, 59)), MealType.lunch);
    });

    test('forTime returns snack between 15:00 and 17:00', () {
      expect(MealType.forTime(DateTime(2026, 1, 1, 15, 0)), MealType.snack);
      expect(MealType.forTime(DateTime(2026, 1, 1, 16, 59)), MealType.snack);
    });

    test('forTime returns dinner from 17:00 onwards', () {
      expect(MealType.forTime(DateTime(2026, 1, 1, 17, 0)), MealType.dinner);
      expect(MealType.forTime(DateTime(2026, 1, 1, 20, 30)), MealType.dinner);
      expect(MealType.forTime(DateTime(2026, 1, 1, 23, 59)), MealType.dinner);
    });

    test('tryParse parses case-insensitively', () {
      expect(MealType.tryParse('breakfast'), MealType.breakfast);
      expect(MealType.tryParse('LUNCH'), MealType.lunch);
      expect(MealType.tryParse('Snack'), MealType.snack);
      expect(MealType.tryParse(' DINNER '), MealType.dinner);
      expect(MealType.tryParse('invalid'), isNull);
      expect(MealType.tryParse(null), isNull);
      expect(MealType.tryParse(''), isNull);
    });

    test('label returns proper capitalized name', () {
      expect(MealType.breakfast.label, 'Breakfast');
      expect(MealType.lunch.label, 'Lunch');
      expect(MealType.snack.label, 'Snack');
      expect(MealType.dinner.label, 'Dinner');
    });
  });
}
