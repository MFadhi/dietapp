import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/disclaimer_banner.dart';
import '../../../domain/entities/food_log_entry.dart';
import '../../../domain/entities/meal_type.dart';
import '../../../domain/entities/nutrition_targets.dart';
import '../../foods/application/food_providers.dart';
import '../../foods/presentation/widgets/food_log_edit_sheet.dart';
import '../../profile/application/profile_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider).value;
    final targets = ref.watch(nutritionTargetsProvider);
    final todayLogsAsync = ref.watch(todayFoodLogsProvider);
    final todayNutrients = ref.watch(todayNutrientsSummaryProvider);

    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final name = profile?.name ?? '';

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.l),
          children: [
            // Greeting Header
            Text(
              name.isEmpty ? _greeting() : '${_greeting()}, $name',
              style: text.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              "Here's your nutritional summary for today.",
              style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.l),

            // Today's Progress Card
            _TodayProgressCard(
              targets: targets,
              eatenKcal: todayNutrients.kcal,
              proteinEaten: todayNutrients.protein,
              carbsEaten: todayNutrients.carbs,
              fatEaten: todayNutrients.fat,
              fibreEaten: todayNutrients.fibre,
              onLogFoodPressed: () => context.push('/foods'),
            ),
            const SizedBox(height: AppSpacing.l),

            // Four Meal Cards
            todayLogsAsync.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.l),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (err, _) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.m),
                  child: Text('Error loading meal logs: $err'),
                ),
              ),
              data: (logs) {
                return Column(
                  children: MealType.values.map((meal) {
                    final mealEntries = logs.where((e) => e.meal == meal).toList();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.m),
                      child: _MealCard(
                        meal: meal,
                        entries: mealEntries,
                        onAddPressed: () => context.push('/foods?meal=${meal.name}'),
                        onEntryTap: (entry) {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(AppRadius.sheet),
                              ),
                            ),
                            builder: (ctx) => FoodLogEditSheet(entry: entry),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: AppSpacing.s),
            const DisclaimerBanner(),
          ],
        ),
      ),
    );
  }
}

class _TodayProgressCard extends StatelessWidget {
  const _TodayProgressCard({
    required this.targets,
    required this.eatenKcal,
    required this.proteinEaten,
    required this.carbsEaten,
    required this.fatEaten,
    required this.fibreEaten,
    required this.onLogFoodPressed,
  });

  final NutritionTargets? targets;
  final double eatenKcal;
  final double proteinEaten;
  final double carbsEaten;
  final double fatEaten;
  final double fibreEaten;
  final VoidCallback onLogFoodPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    final targetKcal = targets?.calories ?? 2000;
    final kcalProgress = (eatenKcal / targetKcal).clamp(0.0, 1.0);
    final remainingKcal = targetKcal - eatenKcal.round();

    final targetP = targets?.proteinG ?? 75;
    final targetC = targets?.carbsG ?? 250;
    final targetF = targets?.fatG ?? 65;
    final targetFibre = targets?.fibreG ?? 30;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l - 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Today’s Calories', style: text.titleMedium),
                FilledButton.tonalIcon(
                  onPressed: onLogFoodPressed,
                  icon: const Icon(Icons.add_rounded, size: 20),
                  label: const Text('Log food'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(96, 40),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.m),

            // Calories numbers
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '${eatenKcal.round()}',
                  style: text.displaySmall?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' / $targetKcal kcal',
                  style: text.titleMedium?.copyWith(color: scheme.onSurfaceVariant),
                ),
                const Spacer(),
                Text(
                  remainingKcal >= 0
                      ? '$remainingKcal kcal left'
                      : '${remainingKcal.abs()} kcal over',
                  style: text.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: remainingKcal >= 0 ? scheme.primary : scheme.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s),

            // Animated Calorie Progress Bar
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: kcalProgress),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: value,
                    minHeight: 10,
                    backgroundColor: scheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      remainingKcal < 0 ? AppColors.warning : scheme.primary,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.l),

            // Macro Progress Bars
            Row(
              children: [
                Expanded(
                  child: _MacroProgressItem(
                    label: 'Protein',
                    eaten: proteinEaten,
                    target: targetP.toDouble(),
                    color: AppColors.protein,
                  ),
                ),
                const SizedBox(width: AppSpacing.s),
                Expanded(
                  child: _MacroProgressItem(
                    label: 'Carbs',
                    eaten: carbsEaten,
                    target: targetC.toDouble(),
                    color: AppColors.carbs,
                  ),
                ),
                const SizedBox(width: AppSpacing.s),
                Expanded(
                  child: _MacroProgressItem(
                    label: 'Fat',
                    eaten: fatEaten,
                    target: targetF.toDouble(),
                    color: AppColors.fat,
                  ),
                ),
                const SizedBox(width: AppSpacing.s),
                Expanded(
                  child: _MacroProgressItem(
                    label: 'Fibre',
                    eaten: fibreEaten,
                    target: targetFibre.toDouble(),
                    color: AppColors.fibre,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MacroProgressItem extends StatelessWidget {
  const _MacroProgressItem({
    required this.label,
    required this.eaten,
    required this.target,
    required this.color,
  });

  final String label;
  final double eaten;
  final double target;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final progress = target > 0 ? (eaten / target).clamp(0.0, 1.0) : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 4),
            Text(label, style: text.labelSmall),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '${eaten.round()} / ${target.round()}g',
          style: text.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            backgroundColor: scheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _MealCard extends StatelessWidget {
  const _MealCard({
    required this.meal,
    required this.entries,
    required this.onAddPressed,
    required this.onEntryTap,
  });

  final MealType meal;
  final List<FoodLogEntry> entries;
  final VoidCallback onAddPressed;
  final ValueChanged<FoodLogEntry> onEntryTap;

  IconData _mealIcon(MealType m) => switch (m) {
        MealType.breakfast => Icons.wb_sunny_outlined,
        MealType.lunch => Icons.wb_twighlight,
        MealType.snack => Icons.cookie_outlined,
        MealType.dinner => Icons.nightlight_outlined,
      };

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    final mealKcal = entries.fold<double>(0.0, (sum, e) => sum + e.nutrients.kcal).round();

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.m,
          vertical: AppSpacing.s + 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Meal Header
            Row(
              children: [
                Icon(_mealIcon(meal), size: 20, color: scheme.primary),
                const SizedBox(width: AppSpacing.s),
                Text(meal.label, style: text.titleMedium),
                const Spacer(),
                Text(
                  '$mealKcal kcal',
                  style: text.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: mealKcal > 0 ? scheme.primary : scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                IconButton(
                  tooltip: 'Add food to ${meal.label}',
                  onPressed: onAddPressed,
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  color: scheme.primary,
                ),
              ],
            ),

            if (entries.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
                child: Text(
                  'No foods logged yet. Tap + to add.',
                  style: text.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else ...[
              const Divider(),
              for (var i = 0; i < entries.length; i++) ...[
                if (i > 0) const Divider(height: 1),
                InkWell(
                  onTap: () => onEntryTap(entries[i]),
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(entries[i].foodName, style: text.bodyLarge),
                              Text(
                                '${_formatQty(entries[i].quantity)} × ${entries[i].portionLabel} '
                                '(${ (entries[i].portionGrams * entries[i].quantity).round() }g)',
                                style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${entries[i].nutrients.kcal.round()} kcal',
                          style: text.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.chevron_right_rounded, size: 18, color: scheme.onSurfaceVariant),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  String _formatQty(double q) {
    if (q == q.truncateToDouble()) return q.toInt().toString();
    return q.toStringAsFixed(1);
  }
}
