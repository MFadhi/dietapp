import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/meal_type.dart';
import '../../domain/entities/user_profile.dart';
import '../../features/foods/presentation/food_detail_screen.dart';
import '../../features/foods/presentation/food_search_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/onboarding/presentation/splash_screen.dart';
import '../../features/plan/presentation/plan_screen.dart';
import '../../features/profile/application/profile_providers.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/recipes/presentation/recipes_screen.dart';
import '../../features/scan/presentation/scan_screen.dart';
import '../../features/shell/presentation/home_shell.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Tab order matters: HomeShell expects Scan at index 2 (the centre button).
final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen<AsyncValue<UserProfile?>>(
    profileControllerProvider,
    (_, __) => refresh.value++,
  );
  ref.onDispose(refresh.dispose);

  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash',
    refreshListenable: refresh,
    redirect: (context, state) {
      final profile = ref.read(profileControllerProvider);
      final loc = state.matchedLocation;

      if (profile.isLoading || profile.hasError) {
        return loc == '/splash' ? null : '/splash';
      }
      if (profile.value == null) {
        return loc == '/onboarding' ? null : '/onboarding';
      }
      if (loc == '/splash' || loc == '/onboarding') return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
      GoRoute(
        path: '/foods',
        parentNavigatorKey: rootNavigatorKey, // sits above bottom navigation
        builder: (context, state) {
          final mealStr = state.uri.queryParameters['meal'];
          final meal = MealType.tryParse(mealStr);
          return FoodSearchScreen(initialMeal: meal);
        },
      ),
      GoRoute(
        path: '/foods/:id',
        parentNavigatorKey: rootNavigatorKey, // sits above bottom navigation
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          final mealStr = state.uri.queryParameters['meal'];
          final meal = MealType.tryParse(mealStr);
          return FoodDetailScreen(foodId: id, initialMeal: meal);
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => HomeShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/plan', builder: (_, __) => const PlanScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/scan', builder: (_, __) => const ScanScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/recipes', builder: (_, __) => const RecipesScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/profile',
              builder: (_, __) => const ProfileScreen(),
              routes: [
                GoRoute(
                  path: 'edit',
                  parentNavigatorKey: rootNavigatorKey, // full screen, above the tab bar
                  builder: (_, __) => const OnboardingScreen(isEditing: true),
                ),
              ],
            ),
          ]),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
