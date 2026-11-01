import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/option_card.dart';
import '../../../../domain/entities/user_profile.dart';
import '../../../profile/presentation/enum_labels.dart';
import '../../application/onboarding_draft.dart';

class LifestyleStep extends StatelessWidget {
  const LifestyleStep({super.key, required this.draft, required this.onChanged});

  final OnboardingDraft draft;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Lifestyle & goal', style: text.headlineMedium),
        const SizedBox(height: AppSpacing.s),
        Text(
          'How active are you in a typical week?',
          style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.m),
        for (final a in ActivityLevel.values) ...[
          OptionCard(
            title: a.label,
            subtitle: a.description,
            selected: draft.activityLevel == a,
            onTap: () {
              draft.activityLevel = a;
              onChanged();
            },
          ),
          const SizedBox(height: AppSpacing.s + 4),
        ],
        const SizedBox(height: AppSpacing.m),
        Text('What is your goal?', style: text.titleLarge),
        const SizedBox(height: AppSpacing.m),
        for (final g in Goal.values) ...[
          OptionCard(
            title: g.label,
            subtitle: g.description,
            selected: draft.goal == g,
            onTap: () {
              draft.goal = g;
              onChanged();
            },
          ),
          const SizedBox(height: AppSpacing.s + 4),
        ],
      ],
    );
  }
}
