import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './app_card.dart';
import './profile_list_tile.dart';
import '../constants/constants.dart';
import '../../models/user_model.dart';
import '../../services/user_service.dart';

class ProfileMenu extends StatelessWidget {
  final UserModel user;

  const ProfileMenu({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final UserServices userService = UserServices();
    final Size size = MediaQuery.of(context).size;

    Future<void> handleLogOut({required BuildContext context}) async {
      userService.logoutUser(
        onSuccess: () => context.go('/login'),
        onError: (e) => debugPrint('Çıkış yapılırken hata oluştu: $e'),
      );
    }

    return AppCard(
      width: size.width,
      padding: 0.0,
      color: AppColors.white,
      borderColor: AppColors.lightPeriwinkle,
      shadowColor: AppColors.lightPeriwinkle,
      blurRadius: 5.0,
      child: buildMenuItems(
        context: context,
        onLogOut: () => handleLogOut(context: context),
      ),
    );
  }

  Column buildMenuItems({
    required BuildContext context,
    required Function() onLogOut,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileListTile(
          title: 'Favorilerim',
          icon: Icons.favorite_border_outlined,
          onTap: () => context.push('/profile/favorites'),
        ),
        listTileDivider,
        ProfileListTile(
          title: 'Bildirimler',
          icon: Icons.notifications_none_outlined,
          onTap: () => context.push('/profile/notifications'),
        ),
        listTileDivider,
        ProfileListTile(
          title: 'Profili Düzenle',
          icon: Icons.manage_accounts_outlined,
          onTap: () => context.push(
            '/profile/edit',
            extra: user.toMap(),
          ),
        ),
        listTileDivider,
        ProfileListTile(
          title: 'Ayarlar',
          icon: Icons.settings_outlined,
          onTap: () => context.push('/settings'),
        ),
        listTileDivider,
        ProfileListTile(
          title: 'Çıkış Yap',
          icon: Icons.logout_outlined,
          onTap: () => onLogOut(),
          iconColor: AppColors.red,
          textColor: AppColors.red,
        ),
      ],
    );
  }

  static const Widget listTileDivider = Divider(
    color: AppColors.lightPeriwinkle,
    height: 0.0,
    thickness: 0.5,
  );
}
