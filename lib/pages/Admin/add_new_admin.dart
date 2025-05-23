import 'package:flutter/material.dart';

import '../../core/widgets/admin_form_modal.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_circular_indicator.dart';
import '../../models/user_model.dart';
import '../../services/admin_service.dart';
import '../../services/user_service.dart';

class AddNewAdminPage extends StatelessWidget {
  AddNewAdminPage({super.key});

  final AdminServices adminService = AdminServices();
  final UserServices userService = UserServices();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Admin Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomElevatedButton(
              text: 'Yeni Admin Ekle',
              icon: Icons.add,
              width: size.width,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: 16,
                      right: 16,
                      top: 24,
                    ),
                    child: const AdminFormModal(),
                  ),
                );
              },
            ),
            FutureBuilder<List<UserModel>>(
              future: adminService.getAdminUsers(),
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
                final admins = snapshot.data ?? [];
                final String? currentUser = userService.getUserId();
                return AppCard(
                  width: size.width,
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  padding: 0.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: admins.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text('${admins[i].name} ${admins[i].surname}'),
                        subtitle: Text(admins[i].mail),
                        trailing: admins[i].uid == currentUser
                            ? const Icon(Icons.account_circle_outlined)
                            : null,
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
