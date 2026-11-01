import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/macro_chip.dart';
import '../../../../domain/entities/nutrition_targets.dart';

class TargetsCard extends StatelessWidget {
  const TargetsCard({super.key, required this.targets, this.title = 'Your daily targets'});

  final NutritionTargets targets;
  final String title;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final glasses = (targets.waterMl / 250).round();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l - 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: text.titleMedium),
            const SizedBox(height: AppSpacing.s),
            Semantics(
              label: '${targets.calories} kilocalories per day',
              excludeSemantics: true,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '${targets.calories}',
                    style: text.displayMedium?.copyWith(color: scheme.primary),
                  ),
                  const SizedBox(width: AppSpacing.s),
                  Text(
                    'kcal / day',
                    style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.m),
            Wrap(
              spacing: AppSpacing.s,
              runSpacing: AppSpacing.s,
              children: [
                MacroChip(label: 'Protein', value: '${targets.proteinG} g', color: AppColors.protein),
                MacroChip(label: 'Carbs', value: '${targets.carbsG} g', color: AppColors.carbs),
                MacroChip(label: 'Fat', value: '${targets.fatG} g', color: AppColors.fat),
                MacroChip(label: 'Fibre', value: '${targets.fibreG} g', color: AppColors.fibre),
              ],
            ),
            const SizedBox(height: AppSpacing.m),
            const Divider(),
            const SizedBox(height: AppSpacing.m - 4),
            Row(
              children: [
                const Icon(Icons.water_drop_rounded, color: AppColors.water),
                const SizedBox(width: AppSpacing.s + 4),
                Expanded(
                  child: Text(
                    'Water goal: ${(targets.waterMl / 1000).toStringAsFixed(1)} L (about $glasses glasses)',
                    style: text.bodyLarge,
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

/// Transparent "how was this calculated" list.
class CalculationExplainer extends StatelessWidget {
  const CalculationExplainer({super.key, required this.targets});

  final NutritionTargets targets;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Card(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: AppSpacing.m + 4),
          childrenPadding: const EdgeInsets.fromLTRB(
            AppSpacing.m + 4, 0, AppSpacing.m + 4, AppSpacing.m,
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          title: Text('How were these calculated?', style: text.titleMedium),
          children: [
            for (final line in targets.explanations)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.s),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('•  ', style: text.bodyMedium),
                    Expanded(child: Text(line, style: text.bodyMedium)),
                  ],
                ),
              ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'These are general estimates. If you are pregnant, breastfeeding or managing a '
              'medical condition, please check your targets with a doctor or dietitian.',
              style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
