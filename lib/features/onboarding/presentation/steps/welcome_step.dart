import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/disclaimer_banner.dart';

class WelcomeStep extends StatelessWidget {
  const WelcomeStep({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.m),
        Center(
          child: ExcludeSemantics(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(color: scheme.primaryContainer, shape: BoxShape.circle),
              child: const Icon(Icons.eco_rounded, size: 64, color: AppColors.primary),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text('Welcome to ${AppConstants.appName}', style: text.headlineMedium),
        const SizedBox(height: AppSpacing.s),
        Text(
          'Meal plans built around you: your body, your lab results, today\'s weather '
          'and the foods you actually eat.',
          style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.l),
        const _Point(icon: Icons.calculate_rounded, text: 'Daily targets worked out from your profile'),
        const _Point(icon: Icons.no_food_rounded, text: 'Plans that respect your diet and allergies'),
        const _Point(icon: Icons.lock_outline_rounded, text: 'Your profile is stored encrypted on this device'),
        const SizedBox(height: AppSpacing.l),
        const DisclaimerBanner(),
      ],
    );
  }
}

class _Point extends StatelessWidget {
  const _Point({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.m - 4),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: AppSpacing.m),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
