import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../profile/application/profile_providers.dart';

/// Shown while the saved profile loads (or if reading it fails).
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileControllerProvider);
    final text = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: state.hasError
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline_rounded, size: 56),
                    const SizedBox(height: AppSpacing.m),
                    Text("We couldn't open your saved data.",
                        style: text.titleMedium, textAlign: TextAlign.center),
                    const SizedBox(height: AppSpacing.l),
                    FilledButton(
                      onPressed: () => ref.invalidate(profileControllerProvider),
                      child: const Text('Try again'),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.eco_rounded, size: 72, color: AppColors.primary),
                    const SizedBox(height: AppSpacing.m),
                    Text(AppConstants.appName, style: text.headlineMedium),
                    const SizedBox(height: AppSpacing.l),
                    const CircularProgressIndicator(),
                  ],
                ),
        ),
      ),
    );
  }
}
