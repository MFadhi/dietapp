import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';

/// Stores the profile as JSON in the platform keystore/keychain.
/// TODO(Phase 2): move into the drift database if you prefer one store for everything.
class SecureProfileRepository implements ProfileRepository {
  SecureProfileRepository(this._storage);

  static const _key = 'user_profile_v1';
  final FlutterSecureStorage _storage;

  @override
  Future<UserProfile?> load() async {
    final raw = await _storage.read(key: _key);
    if (raw == null) return null;
    try {
      return UserProfile.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      // Unreadable/corrupt data: treat as "no profile" so the user can set up again.
      return null;
    }
  }

  @override
  Future<void> save(UserProfile profile) =>
      _storage.write(key: _key, value: jsonEncode(profile.toJson()));

  @override
  Future<void> clear() => _storage.delete(key: _key);
}
