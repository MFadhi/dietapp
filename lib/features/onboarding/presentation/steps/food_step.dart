import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/option_card.dart';
import '../../../../domain/entities/allergen.dart';
import '../../../../domain/entities/user_profile.dart';
import '../../../profile/presentation/enum_labels.dart';
import '../../application/onboarding_draft.dart';

class FoodStep extends StatefulWidget {
  const FoodStep({super.key, required this.draft, required this.onChanged});

  final OnboardingDraft draft;
  final VoidCallback onChanged;

  @override
  State<FoodStep> createState() => _FoodStepState();
}

class _FoodStepState extends State<FoodStep> {
  final _customController = TextEditingController();

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  void _addCustom() {
    final value = _customController.text.trim().toLowerCase();
    if (value.isEmpty) return;
    setState(() => widget.draft.allergies.add(value));
    _customController.clear();
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final draft = widget.draft;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final custom = draft.allergies.where((a) => !Allergens.common.containsKey(a)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Food preferences', style: text.headlineMedium),
        const SizedBox(height: AppSpacing.s),
        Text(
          'Your meal plans will only include foods that fit.',
          style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.m),
        for (final d in DietType.values) ...[
          OptionCard(
            title: d.label,
            subtitle: d.description,
            selected: draft.dietType == d,
            onTap: () {
              draft.dietType = d;
              widget.onChanged();
            },
          ),
          const SizedBox(height: AppSpacing.s + 4),
        ],
        const SizedBox(height: AppSpacing.m),
        Text('Any allergies?', style: text.titleLarge),
        const SizedBox(height: AppSpacing.xs),
        Text('Optional. Select all that apply.',
            style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
        const SizedBox(height: AppSpacing.m - 4),
        Wrap(
          spacing: AppSpacing.s,
          runSpacing: AppSpacing.s,
          children: [
            for (final entry in Allergens.common.entries)
              FilterChip(
                label: Text(entry.value),
                selected: draft.allergies.contains(entry.key),
                onSelected: (selected) {
                  setState(() {
                    selected ? draft.allergies.add(entry.key) : draft.allergies.remove(entry.key);
                  });
                  widget.onChanged();
                },
              ),
            for (final c in custom)
              InputChip(
                label: Text(Allergens.label(c)),
                onDeleted: () {
                  setState(() => draft.allergies.remove(c));
                  widget.onChanged();
                },
                deleteButtonTooltipMessage: 'Remove ${Allergens.label(c)}',
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.m),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _customController,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Something else?'),
                onSubmitted: (_) => _addCustom(),
              ),
            ),
            const SizedBox(width: AppSpacing.s),
            IconButton.filledTonal(
              onPressed: _addCustom,
              tooltip: 'Add allergy',
              icon: const Icon(Icons.add_rounded),
            ),
          ],
        ),
      ],
    );
  }
}
