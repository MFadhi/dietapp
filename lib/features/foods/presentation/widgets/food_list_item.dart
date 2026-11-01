import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../domain/entities/food.dart';
import '../../../profile/application/profile_providers.dart';
import '../../application/food_providers.dart';
import 'diet_badge.dart';

class FoodListItem extends ConsumerWidget {
  const FoodListItem({
    super.key,
    required this.food,
    required this.onTap,
  });

  final Food food;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final profile = ref.watch(profileControllerProvider).value;
    final compatibility = ref.watch(foodCompatibilityProvider);

    final warnings = profile != null
        ? compatibility.check(food, profile)
        : const [];
    final hasWarning = warnings.isNotEmpty;

    final defaultPortion = food.defaultPortion;
    final portionKcal = food.forGrams(defaultPortion.grams).kcal.round();

    final regionalParts = <String>[];
    if (food.nameHi != null && food.nameHi!.isNotEmpty) {
      regionalParts.add(food.nameHi!);
    }
    if (food.nameKn != null && food.nameKn!.isNotEmpty) {
      regionalParts.add(food.nameKn!);
    }
    final regionalSubtitle = regionalParts.join(' • ');

    return Semantics(
      button: true,
      label: '${food.nameEn}, $portionKcal kilocalories per ${defaultPortion.label}'
          '${hasWarning ? ", Warning: ${warnings.first.message}" : ""}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.control),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.m,
              vertical: AppSpacing.s + 4,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DietBadge(diet: food.diet, size: 20),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              food.nameEn,
                              style: text.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (hasWarning) ...[
                            const SizedBox(width: AppSpacing.xs),
                            Tooltip(
                              message: warnings.map((w) => w.message).join('\n'),
                              child: const Icon(
                                Icons.warning_amber_rounded,
                                size: 18,
                                color: AppColors.warning,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (regionalSubtitle.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          regionalSubtitle,
                          style: text.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      const SizedBox(height: 2),
                      Text(
                        '$portionKcal kcal / ${defaultPortion.label} (${defaultPortion.grams.round()}g)',
                        style: text.bodySmall?.copyWith(
                          color: scheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.s),
                Icon(
                  Icons.chevron_right_rounded,
                  color: scheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
