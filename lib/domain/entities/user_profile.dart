enum Gender { male, female, other }

enum ActivityLevel {
  sedentary(1.2),
  light(1.375),
  moderate(1.55),
  active(1.725),
  veryActive(1.9);

  const ActivityLevel(this.factor);
  final double factor;
}

enum DietType { veg, nonVeg, eggetarian, vegan }

enum Goal { lose, maintain, gain }

/// Input limits. Mifflin-St Jeor is an adult formula, so the app is adults-only.
class ProfileLimits {
  ProfileLimits._();
  static const int minAge = 18;
  static const int maxAge = 100;
  static const double minHeightCm = 100;
  static const double maxHeightCm = 250;
  static const double minWeightKg = 30;
  static const double maxWeightKg = 300;
}

class UserProfile {
  const UserProfile({
    required this.name,
    required this.age,
    required this.gender,
    required this.heightCm,
    required this.weightKg,
    required this.activityLevel,
    required this.dietType,
    required this.allergies,
    required this.goal,
  });

  static const int schemaVersion = 1;

  /// Optional display name (may be empty).
  final String name;
  final int age;
  final Gender gender;
  final double heightCm;
  final double weightKg;
  final ActivityLevel activityLevel;
  final DietType dietType;

  /// Allergen ids (see [Allergens]) or lower-case custom entries.
  final List<String> allergies;
  final Goal goal;

  UserProfile copyWith({
    String? name,
    int? age,
    Gender? gender,
    double? heightCm,
    double? weightKg,
    ActivityLevel? activityLevel,
    DietType? dietType,
    List<String>? allergies,
    Goal? goal,
  }) {
    return UserProfile(
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      activityLevel: activityLevel ?? this.activityLevel,
      dietType: dietType ?? this.dietType,
      allergies: allergies ?? this.allergies,
      goal: goal ?? this.goal,
    );
  }

  Map<String, dynamic> toJson() => {
        'schemaVersion': schemaVersion,
        'name': name,
        'age': age,
        'gender': gender.name,
        'heightCm': heightCm,
        'weightKg': weightKg,
        'activityLevel': activityLevel.name,
        'dietType': dietType.name,
        'allergies': allergies,
        'goal': goal.name,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] as String? ?? '',
      age: (json['age'] as num).toInt(),
      gender: Gender.values.byName(json['gender'] as String),
      heightCm: (json['heightCm'] as num).toDouble(),
      weightKg: (json['weightKg'] as num).toDouble(),
      activityLevel: ActivityLevel.values.byName(json['activityLevel'] as String),
      dietType: DietType.values.byName(json['dietType'] as String),
      allergies: ((json['allergies'] as List?) ?? const <dynamic>[]).cast<String>(),
      goal: Goal.values.byName(json['goal'] as String),
    );
  }
}
