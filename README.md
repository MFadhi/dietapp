# Nutri Sense — Phase 1 & Phase 2

Personalized diet planner (Flutter, Android + iOS). This project now covers **Phase 1** (theme, navigation, onboarding, profile, nutrition targets) and **Phase 2** (offline food database, fuzzy search, nutrition details, food logging).

> **Verification status:** Code was compiled, analyzed (`flutter analyze` — 0 issues), and verified with 57 passing automated tests (`flutter test`). Real-device hardware runs (physical camera, push notifications) are deferred to later phases.

---

## Requirements
- Flutter stable **3.27 or newer** (Dart 3.6+). Tested with Flutter 3.47 / Dart 3.13.
- Material 3 design, Google Fonts (Poppins & Inter).

---

## Setup & Code Generation
```bash
# 1. Fetch dependencies
flutter pub get

# 2. Run Drift code generator for SQLite schema
dart run build_runner build --delete-conflicting-outputs

# 3. Analyze and test
flutter analyze
flutter test

# 4. Run the app
flutter run
```

### Platform Notes
- **Android:** `flutter_secure_storage` needs `minSdk 23` or higher. In `android/app/build.gradle(.kts)`, set `minSdk = 23`.
- **iOS:** Uses platform Keychain for secure storage and SQLite for Drift.

---

## Architecture & Layers
```
lib/
  core/
    constants/       AppConstants (app name, disclaimers)
    router/          AppRouter (GoRouter, routes /foods & /foods/:id above bottom bar)
    theme/           AppColors, AppTheme (calm green wellness, 8-pt grid, WCAG AA)
    widgets/         DisclaimerBanner, MacroChip, OptionCard, FeaturePlaceholder
  domain/            Pure Dart — zero Flutter dependencies (100% unit-testable)
    entities/        Nutrients, Food, Portion, FoodDiet, MealType, FoodLogEntry, UserProfile, NutritionTargets
    repositories/    FoodRepository, FoodLogRepository, ProfileRepository
    services/        FoodSearcher (fuzzy Unicode search), FoodCompatibility (diet/allergens), TargetCalculator, FoodSeedParser
  data/
    database/        AppDatabase (Drift SQLite: Foods, Portions, FoodLogEntries; PRAGMA foreign_keys = ON)
    repositories/    DriftFoodRepository (cached), DriftFoodLogRepository (local day range), SecureProfileRepository
    services/        FoodDatabaseSeeder (assets/data/foods_seed.json)
  features/
    foods/
      application/   food_providers.dart (Riverpod providers for search, filters, logs)
      presentation/  FoodSearchScreen, FoodDetailScreen, DietBadge, FoodListItem, FoodLogEditSheet
    home/            HomeScreen (Today card, animated calorie progress, macro bars, 4 meal cards)
    profile/         ProfileScreen (targets, details, edit, "Delete all data" clearing logs)
    onboarding/      Onboarding wizard & splash screen
    shell/           HomeShell (bottom navigation bar + docked Scan button)
    plan/            Placeholder (Phase 5)
    scan/            Placeholder (Phase 3)
    recipes/         Placeholder (Phase 6)
test/domain/         57 unit tests (search typos/scripts, nutrients, food log scaling, compatibility, seed data validation)
```

---

## Phase 2 Features

### 1. Offline Food Database (Drift / SQLite)
- **`Foods` Table:** id, seedKey (unique), nameEn, nameHi, nameKn, aliases (pipe-separated), category, diet (`vegan`, `veg`, `egg`, `nonveg`), kcalPer100, proteinPer100, carbsPer100, fatPer100, fibrePer100, allergens (comma-separated), tags, isSample, source, barcode.
- **`Portions` Table:** id, foodId (foreign key with `CASCADE` delete), label, grams, isDefault.
- **`FoodLogEntries` Table:** id, foodId (foreign key with `SET NULL` delete), foodName, meal, loggedAt, quantity, portionLabel, portionGrams, kcal, proteinG, carbsG, fatG, fibreG. Snapshot nutrients at logging time.
- Uses `@DataClassName` (`FoodRow`, `PortionRow`, `FoodLogRow`) to avoid clashing with domain entities.
- Foreign keys explicitly enabled via `PRAGMA foreign_keys = ON;`.

### 2. Seed Data (`assets/data/foods_seed.json`)
- 126 authentic Indian foods covering 14 categories: breads, rice & grains, South Indian tiffin, dals, vegetable dishes, egg/meat/fish, dairy, fruits, vegetables, nuts, snacks, sweets, drinks, staples.
- Includes English, Hindi, and Kannada names with regional aliases.
- Approximate macronutrients where kcal roughly matches `4 × protein + 4 × carbs + 9 × fat`.
- 1 to 3 household portions per food (first marked default).
- Top-level disclaimer highlighting that data is sample data to be verified against IFCT 2017.
- Seed is loaded on first launch if the database is empty; if loading fails, the app still starts safely.

### 3. Pure-Dart Domain Layer
- **`Nutrients`:** scale, `+` operator, and `Nutrients.sum()`.
- **`FoodSearcher`:** Offline fuzzy search across English, Hindi, Kannada, and aliases using Unicode-aware regex `[\p{L}\p{M}\p{N}]+`.
  - Scoring: Exact (100), Prefix (90), Word-prefix (80), Substring (70), Levenshtein (62 - 5 × distance with allowed edits based on query length).
  - Matches typos like `"panner"`, `"idly"`, `"chapathi"`, and regional scripts like `"ದೋಸೆ"`.
  - Breaks ties preferring shorter English names.
- **`FoodCompatibility`:** Evaluates diet mismatches (vegan, vegetarian, eggetarian) and allergens (standard IDs + custom free-text allergies). Warns without hiding food.
- **`FoodLogEntry`:** Stores snapshot nutrients; supports `fromFood`, `withQuantity` proportional scaling, `withMeal`, and `withoutId` for undo restoration.

### 4. UI Implementation
- **Food Search (`/foods`, optional `?meal=`):**
  - Search field with clear button.
  - Horizontal category filter chips.
  - "Recent" section displaying recently logged foods.
  - Sample-data disclaimer banner.
  - Food list items with Indian dietary marks (Veg, Vegan, Egg, Non-Veg), default portion kcal, and compatibility warning indicators.
  - Skeleton loading state, empty state ("No matches"), and database error/retry state.
- **Food Detail (`/foods/:id`, optional `?meal=`):**
  - Food titles, category/diet chips, sample data badge.
  - Compatibility notice card (if diet or allergens mismatch).
  - Portion selection chips + custom "Grams" option.
  - Quantity stepper (0.5 increments for standard portions, 10g for grams) with validated text field.
  - Live nutrition card updating kcal, macro chips (`Protein`, `Carbs`, `Fat`, `Fibre`), and per-100g reference line.
  - Meal selection chips (defaults based on time of day or query param).
  - "Add to <Meal>" primary button, pop-back navigation, and confirmation SnackBar.
- **Home Screen:**
  - Greeting header.
  - "Today" card with animated calorie progress bar, remaining/over calorie badge, macro breakdown bars, and "Log food" button.
  - Four meal cards (Breakfast, Lunch, Snack, Dinner) displaying per-meal kcal, entries list, and quick "+" button.
  - Tapping an entry opens `FoodLogEditSheet` to adjust quantity, change meal, Save, or Delete with an Undo SnackBar.
- **Profile:**
  - "Delete all data" deletes both encrypted profile and all logged foods in Drift SQLite.
- **Router:**
  - `/foods` and `/foods/:id` routes registered with `parentNavigatorKey: rootNavigatorKey` above the bottom navigation bar.

---

## Roadmap / TODOs for Later Phases
- [ ] **Phase 3:** Barcode scanning (`mobile_scanner`), nutrition label OCR (`google_mlkit_text_recognition`), Open Food Facts API integration (`dio`), and dashboard nutrition charts (`fl_chart`).
- [ ] **Phase 4:** Lab value interpretation (lipid panel, HbA1c, etc.) and weather-driven hydration tracking (`geolocator`).
- [ ] **Phase 5:** Meal planner, schedule suggestions, and local meal reminders (`flutter_local_notifications`).
- [ ] **Phase 6:** Pantry inventory tracking, recipe suggestions based on ingredients at home, and meal sharing (`share_plus`).
- [ ] **Phase 7:** Multi-language localization (`flutter_localizations`, ARB files for Kannada & Hindi), offline font bundling, and optional cloud sync.
