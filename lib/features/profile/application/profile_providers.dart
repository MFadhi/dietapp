import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/repositories/secure_profile_repository.dart';
import '../../../domain/entities/nutrition_targets.dart';
import '../../../domain/entities/user_profile.dart';
import '../../../domain/repositories/profile_repository.dart';
import '../../../domain/services/target_calculator.dart';
import '../../foods/application/food_providers.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  ),
);

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => SecureProfileRepository(ref.watch(secureStorageProvider)),
);

final targetCalculatorProvider =
    Provider<TargetCalculator>((ref) => const TargetCalculator());

class ProfileController extends AsyncNotifier<UserProfile?> {
  @override
  Future<UserProfile?> build() => ref.read(profileRepositoryProvider).load();

  Future<void> save(UserProfile profile) async {
    await ref.read(profileRepositoryProvider).save(profile);
    state = AsyncData(profile);
  }

  /// Deletes the stored profile and clears the food log database.
  Future<void> clear() async {
    await ref.read(profileRepositoryProvider).clear();
    await ref.read(foodLogRepositoryProvider).deleteAll();
    state = const AsyncData(null);
  }
}

final profileControllerProvider =
    AsyncNotifierProvider<ProfileController, UserProfile?>(ProfileController.new);

final nutritionTargetsProvider = Provider<NutritionTargets?>((ref) {
  final profile = ref.watch(profileControllerProvider).value;
  if (profile == null) return null;
  return ref.watch(targetCalculatorProvider).calculate(profile);
});
