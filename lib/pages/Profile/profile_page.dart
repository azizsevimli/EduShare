import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:edushare/models/user_model.dart';
import 'package:edushare/services/user_data_services.dart';
import 'package:edushare/core/utils/show_snackbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  late Future<UserModel?> userFuture;
  UserData dt = UserData();

  @override
  void initState() {
    super.initState();
    userFuture = dt.getUserData(uid);
  }

  Future<void> logoutBtn(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        context.go('/login');
      }
    } catch (e) {
      if (context.mounted) {
        ShowSnackBar.showSnackBar(context, 'Çıkış yapılırken hata oluştu: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<UserModel?>(
            future: userFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text("Hata oluştu: ${snapshot.error}");
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return Text("Kullanıcı verisi bulunamadı.");
              }

              final user = snapshot.data!;

              return Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      user.imageUrl,
                      scale: 1,
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${user.name}  ${user.surname}'),
                      Text(user.university),
                      Text(user.department),
                    ],
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => logoutBtn(context),
            child: Text('Logout'),
          )
        ],
      ),
    );
  }
}

