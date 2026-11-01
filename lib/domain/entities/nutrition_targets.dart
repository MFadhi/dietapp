class NutritionTargets {
  const NutritionTargets({
    required this.bmr,
    required this.maintenanceCalories,
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.fibreG,
    required this.waterMl,
    required this.explanations,
  });

  /// Basal metabolic rate (kcal/day).
  final int bmr;

  /// BMR x activity factor (kcal/day).
  final int maintenanceCalories;

  /// Daily calorie target after the goal adjustment.
  final int calories;
  final int proteinG;
  final int carbsG;
  final int fatG;
  final int fibreG;

  /// Baseline water goal (Phase 4 adjusts it for weather).
  final int waterMl;

  /// Human-readable steps so the user can see how each number was derived.
  final List<String> explanations;
}
