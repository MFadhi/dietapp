import 'package:diet_app/domain/entities/user_profile.dart';
import 'package:diet_app/domain/services/target_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

UserProfile profile({
  int age = 30,
  Gender gender = Gender.male,
  double heightCm = 175,
  double weightKg = 70,
  ActivityLevel activity = ActivityLevel.moderate,
  Goal goal = Goal.maintain,
}) =>
    UserProfile(
      name: 'Test',
      age: age,
      gender: gender,
      heightCm: heightCm,
      weightKg: weightKg,
      activityLevel: activity,
      dietType: DietType.veg,
      allergies: const [],
      goal: goal,
    );

void main() {
  const calc = TargetCalculator();

  group('BMR (Mifflin-St Jeor)', () {
    test('male: 10w + 6.25h - 5a + 5', () {
      expect(calc.bmr(profile()), closeTo(1648.75, 0.01));
    });
    test('female: ... - 161', () {
      expect(calc.bmr(profile(gender: Gender.female)), closeTo(1482.75, 0.01));
    });
    test('other: midpoint constant (-78)', () {
      expect(calc.bmr(profile(gender: Gender.other)), closeTo(1565.75, 0.01));
    });
  });

  group('calorie targets', () {
    test('maintain = BMR x activity', () {
      final t = calc.calculate(profile());
      expect(t.maintenanceCalories, 2556);
      expect(t.calories, 2556);
    });
    test('lose subtracts 500, gain adds 300', () {
      expect(calc.calculate(profile(goal: Goal.lose)).calories, 2056);
      expect(calc.calculate(profile(goal: Goal.gain)).calories, 2856);
    });
    test('never drops below the safety floor', () {
      final t = calc.calculate(profile(
        age: 25,
        gender: Gender.female,
        heightCm: 150,
        weightKg: 50,
        activity: ActivityLevel.sedentary,
        goal: Goal.lose,
      ));
      expect(t.calories, 1200);
      expect(t.explanations.any((e) => e.contains('safety minimum')), isTrue);
    });
  });

  group('macros, fibre, water', () {
    test('protein is 1.2 g/kg when maintaining', () {
      expect(calc.calculate(profile()).proteinG, 84);
    });
    test('macro energy adds back up to the calorie target', () {
      final t = calc.calculate(profile());
      final energy = t.proteinG * 4 + t.carbsG * 4 + t.fatG * 9;
      expect((energy - t.calories).abs(), lessThanOrEqualTo(12));
    });
    test('protein is capped at 35% of calories', () {
      final t = calc.calculate(profile(
        age: 80,
        gender: Gender.female,
        heightCm: 150,
        weightKg: 120,
        activity: ActivityLevel.sedentary,
        goal: Goal.lose,
      ));
      expect(t.calories, 1392);
      expect(t.proteinG, 122);
    });
    test('fibre stays within 25-38 g', () {
      final t = calc.calculate(profile());
      expect(t.fibreG, inInclusiveRange(25, 38));
    });
    test('water is 35 ml per kg', () {
      expect(calc.calculate(profile()).waterMl, 2450);
    });
  });

  group('validation', () {
    test('rejects under-18s', () {
      expect(() => calc.calculate(profile(age: 17)), throwsArgumentError);
    });
    test('rejects implausible height/weight', () {
      expect(() => calc.calculate(profile(heightCm: 50)), throwsArgumentError);
      expect(() => calc.calculate(profile(weightKg: 500)), throwsArgumentError);
    });
  });

  test('UserProfile JSON round-trip', () {
    final p = profile(goal: Goal.gain).copyWith(allergies: ['peanut', 'sesame']);
    final back = UserProfile.fromJson(p.toJson());
    expect(back.toJson(), p.toJson());
  });
}
