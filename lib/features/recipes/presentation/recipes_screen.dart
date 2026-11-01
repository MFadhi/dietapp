import 'package:flutter/material.dart';

import '../../../core/widgets/feature_placeholder.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipes')),
      body: const FeaturePlaceholder(
        icon: Icons.menu_book_rounded,
        title: 'Recipes',
        message: 'Recipe ideas based on what you have at home are coming soon.',
      ),
    );
  }
}
