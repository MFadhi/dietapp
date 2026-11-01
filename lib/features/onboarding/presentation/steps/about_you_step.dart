import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../domain/entities/user_profile.dart';
import '../../../profile/presentation/enum_labels.dart';
import '../../application/onboarding_draft.dart';

class AboutYouStep extends StatelessWidget {
  const AboutYouStep({super.key, required this.draft, required this.onChanged});

  final OnboardingDraft draft;
  final VoidCallback onChanged;

  static double? _parse(String v) => double.tryParse(v.trim().replaceAll(',', '.'));

  String? _ageError(String? v) {
    if (v == null || v.isEmpty) return 'Enter your age';
    final n = int.tryParse(v);
    if (n == null) return 'Enter a whole number';
    if (n < ProfileLimits.minAge) {
      return 'This app is designed for adults (18+). For younger users, please ask a '
          'doctor or dietitian for guidance.';
    }
    if (n > ProfileLimits.maxAge) return 'Enter an age up to ${ProfileLimits.maxAge}';
    return null;
  }

  String? _rangeError(String? v, double min, double max, String what) {
    if (v == null || v.isEmpty) return 'Enter your $what';
    final n = _parse(v);
    if (n == null) return 'Enter a number';
    if (n < min || n > max) return 'Enter a $what between ${min.round()} and ${max.round()}';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    const decimal = TextInputType.numberWithOptions(decimal: true);
    final decimalFormat = FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About you', style: text.headlineMedium),
        const SizedBox(height: AppSpacing.s),
        Text(
          'We use these to estimate how much energy your body needs.',
          style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.l),
        TextFormField(
          initialValue: draft.name,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          maxLength: 30,
          decoration: const InputDecoration(labelText: 'What should we call you? (optional)'),
          onChanged: (v) {
            draft.name = v;
            onChanged();
          },
        ),
        const SizedBox(height: AppSpacing.s),
        TextFormField(
          initialValue: draft.age?.toString(),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(labelText: 'Age', suffixText: 'years'),
          validator: _ageError,
          onChanged: (v) {
            final n = int.tryParse(v);
            draft.age = (n != null && n >= ProfileLimits.minAge && n <= ProfileLimits.maxAge)
                ? n
                : null;
            onChanged();
          },
        ),
        const SizedBox(height: AppSpacing.m),
        Text('Gender', style: text.titleSmall),
        const SizedBox(height: AppSpacing.s),
        Wrap(
          spacing: AppSpacing.s,
          runSpacing: AppSpacing.s,
          children: [
            for (final g in Gender.values)
              ChoiceChip(
                label: Text(g.label),
                selected: draft.gender == g,
                onSelected: (_) {
                  draft.gender = g;
                  onChanged();
                },
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.s),
        Text(
          'Used only in the energy formula. "Other" uses the midpoint of the male and female values.',
          style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.l),
        TextFormField(
          initialValue: draft.heightCm == null ? null : _fmt(draft.heightCm!),
          keyboardType: decimal,
          textInputAction: TextInputAction.next,
          inputFormatters: [decimalFormat],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(labelText: 'Height', suffixText: 'cm'),
          validator: (v) =>
              _rangeError(v, ProfileLimits.minHeightCm, ProfileLimits.maxHeightCm, 'height'),
          onChanged: (v) {
            final n = _parse(v);
            draft.heightCm =
                (n != null && n >= ProfileLimits.minHeightCm && n <= ProfileLimits.maxHeightCm)
                    ? n
                    : null;
            onChanged();
          },
        ),
        const SizedBox(height: AppSpacing.m),
        TextFormField(
          initialValue: draft.weightKg == null ? null : _fmt(draft.weightKg!),
          keyboardType: decimal,
          textInputAction: TextInputAction.done,
          inputFormatters: [decimalFormat],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(labelText: 'Weight', suffixText: 'kg'),
          validator: (v) =>
              _rangeError(v, ProfileLimits.minWeightKg, ProfileLimits.maxWeightKg, 'weight'),
          onChanged: (v) {
            final n = _parse(v);
            draft.weightKg =
                (n != null && n >= ProfileLimits.minWeightKg && n <= ProfileLimits.maxWeightKg)
                    ? n
                    : null;
            onChanged();
          },
        ),
      ],
    );
  }

  static String _fmt(double v) =>
      v == v.truncateToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(1);
}
