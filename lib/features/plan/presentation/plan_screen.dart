import 'package:flutter/material.dart';

import '../../../core/widgets/feature_placeholder.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meal plan')),
      body: const FeaturePlaceholder(
        icon: Icons.restaurant_menu_rounded,
        title: 'Meal plan',
        message: 'Your daily and weekly meal plans will live here soon.',
      ),
    );
  }
}
