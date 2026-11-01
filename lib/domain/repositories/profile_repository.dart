import '../entities/user_profile.dart';

abstract interface class ProfileRepository {
  /// Returns null when no (readable) profile is stored.
  Future<UserProfile?> load();
  Future<void> save(UserProfile profile);
  Future<void> clear();
}
