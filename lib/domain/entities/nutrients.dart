/// Macronutrient snapshot. Pure Dart – no Flutter imports.
class Nutrients {
  const Nutrients({
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fibre,
  });

  static const zero = Nutrients(kcal: 0, protein: 0, carbs: 0, fat: 0, fibre: 0);

  final double kcal;
  final double protein;
  final double carbs;
  final double fat;
  final double fibre;

  /// Scale all values by [factor] (e.g. 1.5 servings).
  Nutrients scale(double factor) => Nutrients(
        kcal: kcal * factor,
        protein: protein * factor,
        carbs: carbs * factor,
        fat: fat * factor,
        fibre: fibre * factor,
      );

  Nutrients operator +(Nutrients other) => Nutrients(
        kcal: kcal + other.kcal,
        protein: protein + other.protein,
        carbs: carbs + other.carbs,
        fat: fat + other.fat,
        fibre: fibre + other.fibre,
      );

  static Nutrients sum(Iterable<Nutrients> items) =>
      items.fold(zero, (a, b) => a + b);

  @override
  String toString() =>
      'Nutrients(kcal: ${kcal.toStringAsFixed(1)}, P: ${protein.toStringAsFixed(1)}, '
      'C: ${carbs.toStringAsFixed(1)}, F: ${fat.toStringAsFixed(1)}, '
      'fibre: ${fibre.toStringAsFixed(1)})';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Nutrients &&
          kcal == other.kcal &&
          protein == other.protein &&
          carbs == other.carbs &&
          fat == other.fat &&
          fibre == other.fibre;

  @override
  int get hashCode => Object.hash(kcal, protein, carbs, fat, fibre);
}
