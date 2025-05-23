import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar buildAppBar({required BuildContext context,required String currentUserId, int? index}) {
  switch (index) {
    case 0:
      return AppBar(
        title: const Text('eduShare'),
        actions: [
          IconButton(
            icon: const Icon(Icons.mail_outline_outlined),
            color: Colors.white,
            onPressed: () => context.push('/messages/$currentUserId'),
          ),
        ],
      );
    case 1:
      return AppBar(
        title: const Text('Keşfet'),
      );
    case 2:
      return AppBar(
        title: const Text('Materyallerim'),
      );
    case 3:
      return AppBar(
        title: const Text('Profilim'),
      );
    case 4:
      return AppBar(
        title: const Text('Yeni Materyal'),
      );
    default:
      return AppBar(
        title: const Text('eduShare'),
      );
  }
}
