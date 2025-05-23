import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/constants.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/profile_list_tile.dart';
import '../../services/user_service.dart';

class AdminHomePage extends StatelessWidget {
  AdminHomePage({super.key});

  final UserServices userService = UserServices();

  Future<void> onLogOut({required BuildContext context}) async {
    userService.logoutUser(
      onSuccess: () => context.go('/login'),
      onError: (e) => debugPrint('Çıkış yapılırken hata oluştu: $e'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('eduShare Admin'),
      ),
      body: Column(
        children: [
          AppCard(
            width: size.width,
            padding: 0.0,
            color: AppColors.white,
            borderColor: AppColors.lightPeriwinkle,
            shadowColor: AppColors.lightPeriwinkle,
            blurRadius: 5.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MenuListTile(
                  title: 'Kategorileri yönet',
                  icon: Icons.category_outlined,
                  onTap: () => context.push('/admin/edit-category'),
                ),
                listTileDivider,
                MenuListTile(
                  title: 'Kullanıcılar',
                  icon: Icons.switch_account_outlined,
                  onTap: () => context.push(
                    '/admin/users-list',
                  ),
                ),
                listTileDivider,
                MenuListTile(
                  title: 'Yeni admin ekle',
                  icon: Icons.person_add_alt_outlined,
                  onTap: () => context.push('/admin/add-new-admin'),
                ),
                listTileDivider,
                MenuListTile(
                  title: 'Çıkış Yap',
                  icon: Icons.logout_outlined,
                  onTap: () => onLogOut(context: context),
                  iconColor: AppColors.red,
                  textColor: AppColors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const Widget listTileDivider = Divider(
    color: AppColors.lightPeriwinkle,
    height: 0.0,
    thickness: 0.5,
  );
}
