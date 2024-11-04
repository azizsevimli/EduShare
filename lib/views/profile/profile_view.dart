import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/panda_512x512.png'),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kullanıcı Adı',
                ),
                Row(
                  children: [
                    Icon(Icons.apartment_rounded, size: 20),
                    Text('Üniversite'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.school_outlined, size: 20),
                    Text('Bölüm'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ));
  }
}
