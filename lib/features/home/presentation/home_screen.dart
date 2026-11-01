import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/disclaimer_banner.dart';
import '../../profile/application/profile_providers.dart';
import '../../profile/presentation/widgets/targets_card.dart';

/// Phase 1 home: greeting + targets. TODO: weather chip (Phase 4), calorie ring and macro
/// progress (Phase 3), today's meals (Phase 5), water tracker (Phase 3).
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
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final name = profile?.name ?? '';

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.l),
          children: [
            Text(
              name.isEmpty ? _greeting() : '${_greeting()}, $name',
              style: text.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              "Here's your starting point.",
              style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.l),
            if (targets != null) TargetsCard(targets: targets),
            const SizedBox(height: AppSpacing.m),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.l - 4),
                child: Row(
                  children: [
                    const Icon(Icons.restaurant_rounded, color: AppColors.accent),
                    const SizedBox(width: AppSpacing.m),
                    Expanded(
                      child: Text(
                        'Your meals and water tracker will appear here soon.',
                        style: text.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.m),
            const DisclaimerBanner(),
          ],
        ),
      ),
    );
  }
}
