import 'package:flutter/material.dart';

import '../../core/widgets/custom_app_bar.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Bildirimler',
      ),
      body: const Center(
        child: Text('Henüz bildirim yok.'),
      ),
    );
  }
}
