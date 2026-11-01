import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../domain/entities/food_log_entry.dart';
import '../../../../domain/entities/meal_type.dart';
import '../../application/food_providers.dart';

/// Bottom sheet to edit an existing food log entry: adjust quantity, change meal, Save, or Delete with Undo.
class FoodLogEditSheet extends ConsumerStatefulWidget {
  const FoodLogEditSheet({super.key, required this.entry});

  final FoodLogEntry entry;

  @override
  ConsumerState<FoodLogEditSheet> createState() => _FoodLogEditSheetState();
}

class _FoodLogEditSheetState extends ConsumerState<FoodLogEditSheet> {
  late double _quantity;
  late MealType _meal;
  late final TextEditingController _qtyController;

  @override
  void initState() {
    super.initState();
    _quantity = widget.entry.quantity;
    _meal = widget.entry.meal;
    _qtyController = TextEditingController(text: _formatQty(_quantity));
  }

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  String _formatQty(double q) {
    if (q == q.truncateToDouble()) return q.toInt().toString();
    return q.toStringAsFixed(1);
  }

  void _adjust(double delta) {
    final next = _quantity + delta;
    if (next <= 0) return;
    setState(() {
      _quantity = next;
      _qtyController.text = _formatQty(next);
    });
  }

  Future<void> _save() async {
    final updated = widget.entry.withQuantity(_quantity).withMeal(_meal);
    await ref.read(foodLogRepositoryProvider).update(updated);
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Updated ${widget.entry.foodName}'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _delete() async {
    final entry = widget.entry;
    if (entry.id != null) {
      await ref.read(foodLogRepositoryProvider).delete(entry.id!);
    }
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Removed ${entry.foodName}'),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              ref.read(foodLogRepositoryProvider).add(entry.withoutId());
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    // Calculate scaled nutrients
    final scaled = widget.entry.withQuantity(_quantity).nutrients;
    final totalGrams = widget.entry.portionGrams * _quantity;

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.l,
        right: AppSpacing.l,
        top: AppSpacing.l,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.l,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.entry.foodName,
                  style: text.headlineSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          Text(
            '${widget.entry.portionLabel} • ${totalGrams.round()}g • ${scaled.kcal.round()} kcal',
            style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.l),

          // Quantity Stepper
          Text('Quantity (${widget.entry.portionLabel})', style: text.titleSmall),
          const SizedBox(height: AppSpacing.s),
          Row(
            children: [
              IconButton.filledTonal(
                onPressed: () => _adjust(-0.5),
                icon: const Icon(Icons.remove_rounded),
              ),
              const SizedBox(width: AppSpacing.m),
              SizedBox(
                width: 90,
                child: TextField(
                  controller: _qtyController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  ),
                  onChanged: (val) {
                    final q = double.tryParse(val);
                    if (q != null && q > 0) {
                      setState(() {
                        _quantity = q;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.m),
              IconButton.filledTonal(
                onPressed: () => _adjust(0.5),
                icon: const Icon(Icons.add_rounded),
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: Text(
                  '${scaled.kcal.round()} kcal',
                  style: text.titleMedium?.copyWith(color: scheme.primary),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.l),

          // Meal Slot Selection
          Text('Meal Slot', style: text.titleSmall),
          const SizedBox(height: AppSpacing.s),
          Wrap(
            spacing: AppSpacing.s,
            children: MealType.values.map((m) {
              final isSelected = _meal == m;
              return ChoiceChip(
                label: Text(m.label),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _meal = m;
                    });
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Actions: Save & Delete
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: scheme.error,
                    side: BorderSide(color: scheme.error),
                  ),
                  onPressed: _delete,
                  icon: const Icon(Icons.delete_outline_rounded),
                  label: const Text('Delete'),
                ),
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.check_rounded),
                  label: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
