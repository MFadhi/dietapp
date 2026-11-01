import '../../../domain/entities/user_profile.dart';

/// Mutable form state for the onboarding / edit-profile flow.
/// Numeric fields are only set when the typed value is valid, so `null` means "not valid yet".
class OnboardingDraft {
  OnboardingDraft({
    this.name = '',
    this.age,
    this.gender,
    this.heightCm,
    this.weightKg,
    this.activityLevel,
    this.goal,
    this.dietType,
    Set<String>? allergies,
  }) : allergies = allergies ?? <String>{};

  factory OnboardingDraft.fromProfile(UserProfile p) => OnboardingDraft(
        name: p.name,
        age: p.age,
        gender: p.gender,
        heightCm: p.heightCm,
        weightKg: p.weightKg,
        activityLevel: p.activityLevel,
        goal: p.goal,
        dietType: p.dietType,
        allergies: p.allergies.toSet(),
      );

  String name;
  int? age;
  Gender? gender;
  double? heightCm;
  double? weightKg;
  ActivityLevel? activityLevel;
  Goal? goal;
  DietType? dietType;
  final Set<String> allergies;

  bool get isAboutValid =>
      age != null && gender != null && heightCm != null && weightKg != null;
  bool get isLifestyleValid => activityLevel != null && goal != null;
  bool get isFoodValid => dietType != null;
  bool get isComplete => isAboutValid && isLifestyleValid && isFoodValid;

  UserProfile toProfile() {
    assert(isComplete, 'toProfile() called on an incomplete draft');
    return UserProfile(
      name: name.trim(),
      age: age!,
      gender: gender!,
      heightCm: heightCm!,
      weightKg: weightKg!,
      activityLevel: activityLevel!,
      dietType: dietType!,
      allergies: allergies.toList(),
      goal: goal!,
    );
  }
}
