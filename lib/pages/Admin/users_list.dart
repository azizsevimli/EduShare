import 'package:flutter/material.dart';

import '../../core/widgets/app_card.dart';
import '../../core/widgets/custom_circular_indicator.dart';
import '../../models/user_model.dart';
import '../../services/admin_service.dart';

class UsersListPage extends StatelessWidget {
  UsersListPage({super.key});

  final AdminServices adminService = AdminServices();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcılar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<UserModel>>(
              future: adminService.getUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CustomCircularIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Bir hata oluştu: ${snapshot.error}'),
                  );
                }
                final users = snapshot.data ?? [];
                return AppCard(
                  width: size.width,
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  padding: 0.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: users.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text('${users[i].name} ${users[i].surname}'),
                        subtitle: Text(users[i].mail),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
