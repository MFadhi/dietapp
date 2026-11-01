# [APP NAME] — Phase 1

Personalized diet planner (Flutter, Android + iOS). This drop covers **Phase 1**:
project setup, theme, navigation, onboarding, profile and the nutrition-target calculator.

> I could not run Flutter in my build environment, so this code has **not been compiled or
> tested yet**. Run the steps below and send me any analyzer/test errors; I'll fix them first.

## Requirements
- Flutter stable **3.27 or newer** (Dart 3.6+). The theme uses `CardThemeData` and `Color.withValues`.

## Setup
```bash
# 1. In this folder, generate the Android/iOS platform folders (keeps our lib/ and pubspec.yaml):
flutter create --project-name diet_app --platforms=android,ios .

# 2. If `flutter create` added the default counter test, delete it:
rm -f test/widget_test.dart

# 3. Install and check
flutter pub get
flutter analyze
flutter test

# 4. Run
flutter run
```

### Platform notes
- **Android:** `flutter_secure_storage` needs `minSdk 23` or higher. In
  `android/app/build.gradle(.kts)` set `minSdk = 23` if your template uses a lower value.
- **iOS:** nothing extra for Phase 1 (Keychain is used for storage).

## Where to customise
| What | Where |
|---|---|
| App name | `lib/core/constants/app_constants.dart` (`appName`) plus the Android label / iOS display name |
| Colours | `lib/core/theme/app_colors.dart` |
| Theme / fonts | `lib/core/theme/app_theme.dart` |
| Target formulas (deficit, protein g/kg, calorie floors) | `lib/domain/services/target_calculator.dart` |
| API keys | None needed in Phase 1. Later phases add clearly marked `TODO(you)` placeholders (e.g. Open Food Facts user-agent in Phase 3) |

## Structure
```
lib/
  core/        theme, constants, router, shared widgets
  domain/      entities, repository interfaces, TargetCalculator (pure Dart)
  data/        SecureProfileRepository (flutter_secure_storage)
  features/    onboarding, profile, home, shell (bottom nav), plan, scan, recipes
test/domain/   target calculator + profile JSON tests
```

## Phase 1 behaviour
- First launch: welcome + disclaimer -> about you -> lifestyle & goal -> food preferences -> summary -> Home.
- Profile is stored as JSON in the platform keystore/keychain. Profile tab: edit, see targets and
  how they were calculated, delete all data.
- Adults only (18-100); inputs are validated. Calories never go below a general safety floor.
- Plan, Scan and Recipes tabs are friendly placeholders until their phases.

## Known Phase 1 deviations from the spec
- `ColorScheme.primary` is the pressed shade `#1F7A51` (white text on `#2E9E6B` is only ~3.4:1).
  The brand `#2E9E6B` is still used for icons and large graphics. Secondary text and error text
  are also slightly darker than the spec values to meet WCAG AA.
- Fonts load through `google_fonts` at runtime (bundle them in Phase 7 for fully offline first launch).
- Units are metric only for now (unit setting comes in Phase 7).
