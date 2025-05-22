import 'package:flutter/material.dart';
import '../../core/widgets/profile_menu.dart';
import '../../models/user_model.dart';
import '../../services/user_service.dart';
import '../../core/widgets/user_info.dart';
import '../../core/widgets/custom_circular_indicator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserServices _userService = UserServices();
  late Future<UserModel?> userFuture;

  @override
  void initState() {
    super.initState();
    userFuture = _userService.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<UserModel?>(
              future: userFuture,
              builder: (
                BuildContext context,
                AsyncSnapshot<UserModel?> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CustomCircularIndicator();
                }
                if (snapshot.hasError) {
                  return Text("Hata: ${snapshot.error}");
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Text("Kullanıcı verisi bulunamadı.");
                }
                final UserModel user = snapshot.data!;
                return Column(
                  children: [
                    UserInfoCard(user: user),
                    const SizedBox(height: 20.0),
                    ProfileMenu(user: user),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
