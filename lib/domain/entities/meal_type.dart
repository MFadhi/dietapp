/// The four meal slots of the day.
enum MealType {
  breakfast,
  lunch,
  snack,
  dinner;

  /// Pick a default meal based on the time of day.
  static MealType forTime(DateTime time) {
    final hour = time.hour;
    if (hour < 11) return breakfast;
    if (hour < 15) return lunch;
    if (hour < 17) return snack;
    return dinner;
  }

  /// Case-insensitive parse; returns null on failure.
  static MealType? tryParse(String? value) {
    if (value == null || value.isEmpty) return null;
    final lower = value.toLowerCase().trim();
    for (final m in values) {
      if (m.name == lower) return m;
    }
    return null;
  }

  String get label => switch (this) {
        breakfast => 'Breakfast',
        lunch => 'Lunch',
        snack => 'Snack',
        dinner => 'Dinner',
      };
}
