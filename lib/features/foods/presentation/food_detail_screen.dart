import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/disclaimer_banner.dart';
import '../../../core/widgets/macro_chip.dart';
import '../../../domain/entities/food.dart';
import '../../../domain/entities/food_log_entry.dart';
import '../../../domain/entities/meal_type.dart';
import '../../../domain/services/food_compatibility.dart';
import '../../profile/application/profile_providers.dart';
import '../application/food_providers.dart';
import 'widgets/diet_badge.dart';

class FoodDetailScreen extends ConsumerStatefulWidget {
  const FoodDetailScreen({
    super.key,
    required this.foodId,
    this.initialMeal,
  });

  final int foodId;
  final MealType? initialMeal;

  @override
  ConsumerState<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends ConsumerState<FoodDetailScreen> {
  Portion? _selectedPortion;
  bool _isGramsMode = false;
  double _quantity = 1.0;
  late MealType _selectedMeal;
  late final TextEditingController _quantityController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedMeal = widget.initialMeal ?? MealType.forTime(DateTime.now());
    _quantityController = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  void _initPortion(Food food) {
    if (_selectedPortion == null) {
      _selectedPortion = food.defaultPortion;
      _quantity = 1.0;
      _quantityController.text = '1';
    }
  }

  void _onPortionSelected(Portion portion) {
    setState(() {
      _isGramsMode = false;
      _selectedPortion = portion;
      _quantity = 1.0;
      _quantityController.text = '1';
    });
  }

  void _onGramsSelected() {
    setState(() {
      _isGramsMode = true;
      _selectedPortion = Portion.g;
      _quantity = 100.0;
      _quantityController.text = '100';
    });
  }

  void _adjustQuantity(double delta) {
    final newQty = (_quantity + delta);
    if (newQty <= 0) return;
    setState(() {
      _quantity = newQty;
      _quantityController.text = _formatQuantity(newQty);
    });
  }

  String _formatQuantity(double q) {
    if (q == q.truncateToDouble()) {
      return q.toInt().toString();
    }
    return q.toStringAsFixed(1);
  }

  Future<void> _logFood(Food food) async {
    final portion = _selectedPortion ?? food.defaultPortion;
    final entry = FoodLogEntry.fromFood(
      food: food,
      portion: portion,
      quantity: _quantity,
      meal: _selectedMeal,
      loggedAt: DateTime.now(),
    );

    final repo = ref.read(foodLogRepositoryProvider);
    await repo.add(entry);

    if (mounted) {
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Added ${_formatQuantity(_quantity)} ${portion.label} of ${food.nameEn} to ${_selectedMeal.label}',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final foodAsync = ref.watch(foodByIdProvider(widget.foodId));
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final profile = ref.watch(profileControllerProvider).value;
    final compatibility = ref.watch(foodCompatibilityProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Details'),
        elevation: 0,
      ),
      body: foodAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline_rounded, size: 48, color: AppColors.error),
              const SizedBox(height: AppSpacing.m),
              Text('Food not found', style: text.titleMedium),
              const SizedBox(height: AppSpacing.m),
              FilledButton(
                onPressed: () => context.pop(),
                child: const Text('Go back'),
              ),
            ],
          ),
        ),
        data: (food) {
          if (food == null) {
            return const Center(child: Text('Food not found'));
          }

          _initPortion(food);
          final currentPortion = _selectedPortion ?? food.defaultPortion;
          final totalGrams = currentPortion.grams * _quantity;
          final liveNutrients = food.forGrams(totalGrams);

          final warnings = profile != null
              ? compatibility.check(food, profile)
              : <FoodWarning>[];

          final regionalNames = [
            if (food.nameHi != null && food.nameHi!.isNotEmpty) food.nameHi!,
            if (food.nameKn != null && food.nameKn!.isNotEmpty) food.nameKn!,
            ...food.aliases,
          ];

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.l),
              children: [
                // Header: Diet Badge + English Name
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: DietBadge(diet: food.diet, size: 24),
                    ),
                    const SizedBox(width: AppSpacing.m),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(food.nameEn, style: text.headlineSmall),
                          if (regionalNames.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              regionalNames.join(' • '),
                              style: text.bodyMedium?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.m),

                // Category, Diet, and Sample Data Chips
                Wrap(
                  spacing: AppSpacing.s,
                  runSpacing: AppSpacing.xs,
                  children: [
                    Chip(
                      label: Text(food.category),
                      backgroundColor: scheme.surfaceContainerHighest,
                    ),
                    Chip(
                      label: Text(food.diet.name.toUpperCase()),
                      backgroundColor: scheme.surfaceContainerHighest,
                    ),
                    if (food.isSample)
                      const Chip(
                        avatar: Icon(Icons.science_outlined, size: 16),
                        label: Text('Sample Data'),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.m),

                // Compatibility Warning Card
                if (warnings.isNotEmpty) ...[
                  Card(
                    color: AppColors.warning.withValues(alpha: 0.12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      side: const BorderSide(color: AppColors.warning),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.m),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.warning_amber_rounded, color: AppColors.warning),
                              const SizedBox(width: AppSpacing.s),
                              Text(
                                'Compatibility Notice',
                                style: text.titleSmall?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          for (final w in warnings)
                            Padding(
                              padding: const EdgeInsets.only(left: 32, top: 2),
                              child: Text(
                                '• ${w.message}',
                                style: text.bodyMedium?.copyWith(color: AppColors.textPrimary),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.m),
                ],

                // Live Nutrition Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.l - 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nutritional Breakdown', style: text.titleMedium),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '${_formatQuantity(_quantity)} ${currentPortion.label} (${totalGrams.round()} g)',
                          style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                        const SizedBox(height: AppSpacing.m),

                        // Large Kcal Callout
                        Semantics(
                          label: '${liveNutrients.kcal.round()} kilocalories',
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '${liveNutrients.kcal.round()}',
                                style: text.displaySmall?.copyWith(
                                  color: scheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text('kcal', style: text.titleMedium?.copyWith(color: scheme.onSurfaceVariant)),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.m),

                        // Macro Chips
                        Wrap(
                          spacing: AppSpacing.s,
                          runSpacing: AppSpacing.s,
                          children: [
                            MacroChip(
                              label: 'Protein',
                              value: '${liveNutrients.protein.toStringAsFixed(1)}g',
                              color: AppColors.protein,
                            ),
                            MacroChip(
                              label: 'Carbs',
                              value: '${liveNutrients.carbs.toStringAsFixed(1)}g',
                              color: AppColors.carbs,
                            ),
                            MacroChip(
                              label: 'Fat',
                              value: '${liveNutrients.fat.toStringAsFixed(1)}g',
                              color: AppColors.fat,
                            ),
                            MacroChip(
                              label: 'Fibre',
                              value: '${liveNutrients.fibre.toStringAsFixed(1)}g',
                              color: AppColors.fibre,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.m),
                        const Divider(),
                        const SizedBox(height: AppSpacing.s),

                        // Per 100g Reference Line
                        Text(
                          'Per 100g: ${food.nutrientsPer100g.kcal.round()} kcal • '
                          'P ${food.nutrientsPer100g.protein.toStringAsFixed(1)}g • '
                          'C ${food.nutrientsPer100g.carbs.toStringAsFixed(1)}g • '
                          'F ${food.nutrientsPer100g.fat.toStringAsFixed(1)}g • '
                          'Fibre ${food.nutrientsPer100g.fibre.toStringAsFixed(1)}g',
                          style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.l),

                // Portion Selection Chips
                Text('Portion Size', style: text.titleMedium),
                const SizedBox(height: AppSpacing.s),
                Wrap(
                  spacing: AppSpacing.s,
                  runSpacing: AppSpacing.s,
                  children: [
                    for (final p in food.portions)
                      ChoiceChip(
                        label: Text('${p.label} (${p.grams.round()}g)'),
                        selected: !_isGramsMode && _selectedPortion?.id == p.id,
                        onSelected: (selected) {
                          if (selected) _onPortionSelected(p);
                        },
                      ),
                    ChoiceChip(
                      label: const Text('Grams (g)'),
                      selected: _isGramsMode,
                      onSelected: (selected) {
                        if (selected) _onGramsSelected();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.l),

                // Quantity Stepper + Typed Input
                Text('Quantity', style: text.titleMedium),
                const SizedBox(height: AppSpacing.s),
                Row(
                  children: [
                    IconButton.filledTonal(
                      onPressed: () => _adjustQuantity(_isGramsMode ? -10.0 : -0.5),
                      icon: const Icon(Icons.remove_rounded),
                    ),
                    const SizedBox(width: AppSpacing.m),
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        controller: _quantityController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                        ],
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixText: _isGramsMode ? 'g' : null,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                        onChanged: (val) {
                          final parsed = double.tryParse(val);
                          if (parsed != null && parsed > 0) {
                            setState(() {
                              _quantity = parsed;
                            });
                          }
                        },
                        validator: (val) {
                          final parsed = double.tryParse(val ?? '');
                          if (parsed == null || parsed <= 0) return 'Invalid';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.m),
                    IconButton.filledTonal(
                      onPressed: () => _adjustQuantity(_isGramsMode ? 10.0 : 0.5),
                      icon: const Icon(Icons.add_rounded),
                    ),
                    const SizedBox(width: AppSpacing.m),
                    Expanded(
                      child: Text(
                        _isGramsMode
                            ? '(${_formatQuantity(_quantity)} grams)'
                            : '= ${totalGrams.round()} grams',
                        style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.l),

                // Meal Selection Chips
                Text('Meal Slot', style: text.titleMedium),
                const SizedBox(height: AppSpacing.s),
                Wrap(
                  spacing: AppSpacing.s,
                  children: MealType.values.map((m) {
                    final isSelected = _selectedMeal == m;
                    return ChoiceChip(
                      label: Text(m.label),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedMeal = m;
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.xl),

                // Primary Log Button
                FilledButton.icon(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _logFood(food);
                    }
                  },
                  icon: const Icon(Icons.add_task_rounded),
                  label: Text('Add to ${_selectedMeal.label}'),
                ),
                const SizedBox(height: AppSpacing.m),

                // Disclaimer Banner
                const DisclaimerBanner(),
              ],
            ),
          );
        },
      ),
    );
  }
}
