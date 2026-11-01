import '../../../domain/entities/user_profile.dart';

// TODO(Phase 7): move these strings into l10n (ARB) files for Kannada/Hindi.

extension GenderLabel on Gender {
  String get label => switch (this) {
        Gender.male => 'Male',
        Gender.female => 'Female',
        Gender.other => 'Other',
      };
}

extension ActivityLevelLabel on ActivityLevel {
  String get label => switch (this) {
        ActivityLevel.sedentary => 'Sedentary',
        ActivityLevel.light => 'Lightly active',
        ActivityLevel.moderate => 'Moderately active',
        ActivityLevel.active => 'Very active',
        ActivityLevel.veryActive => 'Extra active',
      };

  String get description => switch (this) {
        ActivityLevel.sedentary => 'Desk job, little or no exercise',
        ActivityLevel.light => 'Light exercise 1-3 days a week',
        ActivityLevel.moderate => 'Moderate exercise 3-5 days a week',
        ActivityLevel.active => 'Hard exercise 6-7 days a week',
        ActivityLevel.veryActive => 'Physical job plus hard training',
      };
}

extension DietTypeLabel on DietType {
  String get label => switch (this) {
        DietType.veg => 'Vegetarian',
        DietType.nonVeg => 'Non-vegetarian',
        DietType.eggetarian => 'Eggetarian',
        DietType.vegan => 'Vegan',
      };

  String get description => switch (this) {
        DietType.veg => 'No meat, fish or eggs',
        DietType.nonVeg => 'Includes meat, fish and eggs',
        DietType.eggetarian => 'Vegetarian, plus eggs',
        DietType.vegan => 'No animal products, including dairy',
      };
}

extension GoalLabel on Goal {
  String get label => switch (this) {
        Goal.lose => 'Lose weight',
        Goal.maintain => 'Maintain weight',
        Goal.gain => 'Gain weight',
      };

  String get description => switch (this) {
        Goal.lose => 'A gentle deficit of about 500 kcal a day',
        Goal.maintain => 'Eat to match what you burn',
        Goal.gain => 'A modest surplus of about 300 kcal a day',
      };
}
