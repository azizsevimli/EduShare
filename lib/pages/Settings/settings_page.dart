import 'package:flutter/material.dart';

import '../../core/widgets/custom_app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Ayarlar',
      ),
      body: const Center(
        child: Text('Ayarlar sayfası burada olacak.'),
      ),
    );
  }
}
