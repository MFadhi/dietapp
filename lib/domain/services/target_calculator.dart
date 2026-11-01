import '../entities/nutrition_targets.dart';
import '../entities/user_profile.dart';

/// Pure-Dart nutrition target calculator.
/// BMR: Mifflin-St Jeor. Targets are general estimates, not medical advice.
class TargetCalculator {
  const TargetCalculator();

  static const double lossDeficitKcal = 500;
  static const double gainSurplusKcal = 300;
  static const double fatShare = 0.25; // of calories
  static const double maxProteinShare = 0.35; // of calories
  static const double fibrePer1000Kcal = 14;
  static const double minFibreG = 25;
  static const double maxFibreG = 38;
  static const double waterMlPerKg = 35;

  /// Mifflin-St Jeor. `other` uses the midpoint of the male (+5) and female (-161) constants.
  double bmr(UserProfile p) {
    _validate(p);
    final base = 10 * p.weightKg + 6.25 * p.heightCm - 5 * p.age;
    return base + _genderConstant(p.gender);
  }

  NutritionTargets calculate(UserProfile p) {
    final bmrValue = bmr(p);
    final maintenance = bmrValue * p.activityLevel.factor;
    final notes = <String>[
      'Resting energy (BMR, Mifflin-St Jeor): ${bmrValue.round()} kcal/day.',
      'Activity multiplier x${p.activityLevel.factor} gives maintenance energy of about '
          '${maintenance.round()} kcal/day.',
    ];

    double calories;
    switch (p.goal) {
      case Goal.lose:
        calories = maintenance - lossDeficitKcal;
        notes.add('Goal "lose": ${lossDeficitKcal.round()} kcal/day below maintenance.');
      case Goal.maintain:
        calories = maintenance;
        notes.add('Goal "maintain": no calorie adjustment.');
      case Goal.gain:
        calories = maintenance + gainSurplusKcal;
        notes.add('Goal "gain": ${gainSurplusKcal.round()} kcal/day above maintenance.');
    }

    final floor = _calorieFloor(p.gender);
    if (calories < floor) {
      calories = floor.toDouble();
      notes.add('Raised to the general safety minimum of $floor kcal/day. '
          'Please talk to a doctor or dietitian before eating less than this.');
    }
    final kcal = calories.round();

    // Protein: g per kg of body weight, capped at a share of calories.
    final perKg = switch (p.goal) {
      Goal.lose => 1.6,
      Goal.maintain => 1.2,
      Goal.gain => 1.6,
    };
    var proteinRaw = perKg * p.weightKg;
    final proteinCap = maxProteinShare * kcal / 4;
    final capped = proteinRaw > proteinCap;
    if (capped) proteinRaw = proteinCap;
    final proteinG = proteinRaw.round();
    notes.add('Protein: $perKg g per kg x ${_trim(p.weightKg)} kg'
        '${capped ? ', limited to ${(maxProteinShare * 100).round()}% of calories' : ''}'
        ' = $proteinG g.');

    final fatG = (fatShare * kcal / 9).round();
    notes.add('Fat: ${(fatShare * 100).round()}% of calories = $fatG g.');

    final carbsRaw = (kcal - proteinG * 4 - fatG * 9) / 4;
    final carbsG = carbsRaw < 0 ? 0 : carbsRaw.round();
    notes.add('Carbohydrates: the remaining calories = $carbsG g.');

    final fibreG =
        (fibrePer1000Kcal * kcal / 1000).clamp(minFibreG, maxFibreG).round();
    notes.add('Fibre: ${fibrePer1000Kcal.round()} g per 1000 kcal, kept between '
        '${minFibreG.round()} and ${maxFibreG.round()} g = $fibreG g.');

    final waterMl =
        (((p.weightKg * waterMlPerKg) / 50).round() * 50).clamp(1500, 4000).toInt();
    notes.add('Water: ${waterMlPerKg.round()} ml per kg, rounded = $waterMl ml '
        '(adjusted for weather in a later step).');

    return NutritionTargets(
      bmr: bmrValue.round(),
      maintenanceCalories: maintenance.round(),
      calories: kcal,
      proteinG: proteinG,
      carbsG: carbsG,
      fatG: fatG,
      fibreG: fibreG,
      waterMl: waterMl,
      explanations: List.unmodifiable(notes),
    );
  }

  static double _genderConstant(Gender g) => switch (g) {
        Gender.male => 5,
        Gender.female => -161,
        Gender.other => -78,
      };

  static int _calorieFloor(Gender g) => switch (g) {
        Gender.male => 1500,
        Gender.female => 1200,
        Gender.other => 1350,
      };

  static String _trim(double v) =>
      v == v.truncateToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(1);

  static void _validate(UserProfile p) {
    if (p.age < ProfileLimits.minAge || p.age > ProfileLimits.maxAge) {
      throw ArgumentError.value(p.age, 'age',
          'must be between ${ProfileLimits.minAge} and ${ProfileLimits.maxAge}');
    }
    if (p.heightCm < ProfileLimits.minHeightCm || p.heightCm > ProfileLimits.maxHeightCm) {
      throw ArgumentError.value(p.heightCm, 'heightCm', 'out of supported range');
    }
    if (p.weightKg < ProfileLimits.minWeightKg || p.weightKg > ProfileLimits.maxWeightKg) {
      throw ArgumentError.value(p.weightKg, 'weightKg', 'out of supported range');
    }
  }
}
