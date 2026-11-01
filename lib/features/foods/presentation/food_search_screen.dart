import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/disclaimer_banner.dart';
import '../../../domain/entities/food.dart';
import '../../../domain/entities/meal_type.dart';
import '../application/food_providers.dart';
import 'widgets/food_list_item.dart';

class FoodSearchScreen extends ConsumerStatefulWidget {
  const FoodSearchScreen({super.key, this.initialMeal});

  final MealType? initialMeal;

  @override
  ConsumerState<FoodSearchScreen> createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends ConsumerState<FoodSearchScreen> {
  late final TextEditingController _searchController;
  final _categories = const [
    'All',
    'breads',
    'rice and grains',
    'South Indian tiffin',
    'dals',
    'vegetable dishes',
    'egg/meat/fish',
    'dairy',
    'fruits',
    'vegetables',
    'nuts',
    'snacks',
    'sweets',
    'drinks',
    'staples',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatCategoryLabel(String cat) {
    if (cat == 'All') return 'All';
    if (cat == 'South Indian tiffin') return 'South Indian';
    if (cat == 'egg/meat/fish') return 'Egg / Meat / Fish';
    return cat[0].toUpperCase() + cat.substring(1);
  }

  void _onFoodSelected(Food food) {
    final mealParam = widget.initialMeal != null ? '?meal=${widget.initialMeal!.name}' : '';
    context.push('/foods/${food.id}$mealParam');
  }

  Future<void> _retrySeeding() async {
    final success = await ref.read(foodDatabaseSeederProvider).forceSeed();
    if (success) {
      ref.invalidate(allFoodsProvider);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load foods. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final allFoodsAsync = ref.watch(allFoodsProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final searchResultsAsync = ref.watch(searchResultsProvider);
    final recentFoodsAsync = ref.watch(recentFoodsProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialMeal != null
            ? 'Log ${widget.initialMeal!.label}'
            : 'Food Search'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.m, 0, AppSpacing.m, AppSpacing.s),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search "paneer", "dosa", "idli", "chapathi"...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(searchQueryProvider.notifier).state = '';
                        },
                      )
                    : null,
              ),
              onChanged: (val) {
                ref.read(searchQueryProvider.notifier).state = val;
              },
            ),
          ),

          // Category Filter Chips
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.s),
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = selectedCategory.toLowerCase() == cat.toLowerCase();
                return ChoiceChip(
                  label: Text(_formatCategoryLabel(cat)),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      ref.read(selectedCategoryProvider.notifier).state = cat;
                    }
                  },
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.s),

          // Sample Data Disclaimer Banner
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.m),
            child: DisclaimerBanner(
              text: 'Sample data: approximate values for demonstration. Please verify against IFCT 2017.',
            ),
          ),
          const SizedBox(height: AppSpacing.s),

          // Body States: Loading, Error, Empty, or List
          Expanded(
            child: allFoodsAsync.when(
              loading: () => _buildSkeletonLoader(context),
              error: (err, stack) => _buildErrorState(context),
              data: (allFoods) {
                if (allFoods.isEmpty) {
                  return _buildEmptyDatabaseState(context);
                }

                return searchResultsAsync.when(
                  loading: () => _buildSkeletonLoader(context),
                  error: (err, stack) => _buildErrorState(context),
                  data: (results) {
                    final isQueryEmpty = searchQuery.trim().isEmpty;
                    final recentFoods = recentFoodsAsync.value ?? const [];

                    if (isQueryEmpty && results.isEmpty) {
                      return Center(
                        child: Text(
                          'No foods in this category',
                          style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      );
                    }

                    if (!isQueryEmpty && results.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.xl),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.search_off_rounded, size: 56, color: scheme.onSurfaceVariant),
                              const SizedBox(height: AppSpacing.m),
                              Text('No matches', style: text.titleMedium),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                'Try checking for typos or searching by regional names.',
                                style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: results.length + (isQueryEmpty && recentFoods.isNotEmpty ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (isQueryEmpty && recentFoods.isNotEmpty) {
                          if (index == 0) {
                            return _buildRecentSection(context, recentFoods);
                          }
                          final food = results[index - 1];
                          return FoodListItem(
                            food: food,
                            onTap: () => _onFoodSelected(food),
                          );
                        }

                        final food = results[index];
                        return FoodListItem(
                          food: food,
                          onTap: () => _onFoodSelected(food),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSection(BuildContext context, List<Food> recentFoods) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.m, AppSpacing.s, AppSpacing.m, AppSpacing.xs),
          child: Row(
            children: [
              const Icon(Icons.history_rounded, size: 18, color: AppColors.primary),
              const SizedBox(width: AppSpacing.xs + 2),
              Text(
                'Recently logged',
                style: text.titleSmall?.copyWith(color: scheme.primary),
              ),
            ],
          ),
        ),
        for (final food in recentFoods)
          FoodListItem(
            food: food,
            onTap: () => _onFoodSelected(food),
          ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.m),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.m, AppSpacing.s, AppSpacing.m, AppSpacing.xs),
          child: Text(
            'All foods',
            style: text.titleSmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }

  Widget _buildSkeletonLoader(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListView.builder(
      itemCount: 8,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140,
                    height: 16,
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 90,
                    height: 12,
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded, size: 56, color: AppColors.error),
            const SizedBox(height: AppSpacing.m),
            Text('Could not load foods', style: text.titleLarge),
            const SizedBox(height: AppSpacing.s),
            Text(
              'There was a problem loading the food database.',
              style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.l),
            FilledButton.icon(
              onPressed: _retrySeeding,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry / Re-seed database'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyDatabaseState(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inventory_2_outlined, size: 56, color: scheme.onSurfaceVariant),
            const SizedBox(height: AppSpacing.m),
            Text('Food database is empty', style: text.titleLarge),
            const SizedBox(height: AppSpacing.s),
            Text(
              'Load the initial offline Indian food database.',
              style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.l),
            FilledButton.icon(
              onPressed: _retrySeeding,
              icon: const Icon(Icons.download_rounded),
              label: const Text('Seed foods database'),
            ),
          ],
        ),
      ),
    );
  }
}
