import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO(Phase 2): initialise the drift database provider override here.
  // TODO(Phase 7): optional Firebase/Supabase init (sync is a placeholder; app works without a backend).
  runApp(const ProviderScope(child: DietApp()));
}
