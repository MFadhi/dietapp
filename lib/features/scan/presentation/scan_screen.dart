import 'package:flutter/material.dart';

import '../../../core/widgets/feature_placeholder.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan food')),
      body: const FeaturePlaceholder(
        icon: Icons.qr_code_scanner_rounded,
        title: 'Scan food',
        message: 'Scan barcodes, nutrition labels and meals here soon.',
      ),
    );
  }
}
