import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/disclaimer_banner.dart';
import '../../../../domain/services/target_calculator.dart';
import '../../../profile/presentation/widgets/targets_card.dart';
import '../../application/onboarding_draft.dart';

class SummaryStep extends StatelessWidget {
  const SummaryStep({super.key, required this.draft});

  final OnboardingDraft draft;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final targets = const TargetCalculator().calculate(draft.toProfile());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your starting targets', style: text.headlineMedium),
        const SizedBox(height: AppSpacing.s),
        Text(
          'You can change your details any time from the Profile tab.',
          style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.l),
        TargetsCard(targets: targets, title: 'Daily targets'),
        const SizedBox(height: AppSpacing.m),
        CalculationExplainer(targets: targets),
        const SizedBox(height: AppSpacing.m),
        const DisclaimerBanner(),
      ],
    );
  }
}
