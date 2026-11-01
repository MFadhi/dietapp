import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/disclaimer_banner.dart';
import '../../../domain/entities/allergen.dart';
import '../application/profile_providers.dart';
import 'enum_labels.dart';
import 'widgets/targets_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static String _num(double v) =>
      v == v.truncateToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(1);

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final scheme = Theme.of(context).colorScheme;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete all data?'),
        content: const Text(
          "This removes your profile from this device and can't be undone.",
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: scheme.error,
              foregroundColor: scheme.onError,
              minimumSize: const Size(64, 48),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      // The router sends the user back to onboarding once the profile is gone.
      await ref.read(profileControllerProvider.notifier).clear();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider).value;
    final targets = ref.watch(nutritionTargetsProvider);
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    if (profile == null || targets == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final allergies = profile.allergies.isEmpty
        ? 'None'
        : profile.allergies.map(Allergens.label).join(', ');
    final rows = <(String, String)>[
      ('Age', '${profile.age} years'),
      ('Gender', profile.gender.label),
      ('Height', '${_num(profile.heightCm)} cm'),
      ('Weight', '${_num(profile.weightKg)} kg'),
      ('Activity', profile.activityLevel.label),
      ('Goal', profile.goal.label),
      ('Diet', profile.dietType.label),
      ('Allergies', allergies),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.l, AppSpacing.s, AppSpacing.l, AppSpacing.l,
        ),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: scheme.primaryContainer,
                child: Text(
                  profile.name.isEmpty ? '?' : String.fromCharCode(profile.name.runes.first).toUpperCase(),
                  style: text.headlineSmall?.copyWith(color: scheme.onPrimaryContainer),
                ),
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: Text(
                  profile.name.isEmpty ? 'Your profile' : profile.name,
                  style: text.headlineSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.l),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.l - 4,
                vertical: AppSpacing.s,
              ),
              child: Column(
                children: [
                  for (var i = 0; i < rows.length; i++) ...[
                    if (i > 0) const Divider(),
                    _InfoRow(label: rows[i].$1, value: rows[i].$2),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.m),
          FilledButton.icon(
            onPressed: () => context.push('/profile/edit'),
            icon: const Icon(Icons.edit_rounded),
            label: const Text('Edit profile'),
          ),
          const SizedBox(height: AppSpacing.l),
          TargetsCard(targets: targets),
          const SizedBox(height: AppSpacing.m),
          CalculationExplainer(targets: targets),
          const SizedBox(height: AppSpacing.l),
          const DisclaimerBanner(),
          const SizedBox(height: AppSpacing.m),
          // TODO(Phase 7): replace with the full privacy & disclaimer page in Settings.
          const DisclaimerBanner(
            text: 'Privacy: your profile is stored encrypted on this device only.',
          ),
          const SizedBox(height: AppSpacing.l),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: scheme.error,
              side: BorderSide(color: scheme.error),
            ),
            onPressed: () => _confirmDelete(context, ref),
            icon: const Icon(Icons.delete_outline_rounded),
            label: const Text('Delete all data'),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.m - 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 104,
            child: Text(label, style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
          ),
          Expanded(child: Text(value, style: text.titleSmall)),
        ],
      ),
    );
  }
}
