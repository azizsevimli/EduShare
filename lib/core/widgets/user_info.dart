import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../constants/constants.dart';

class UserInfoCard extends StatelessWidget {
  final UserModel user;

  const UserInfoCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        width: width * 0.90,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildCircleAvatar(user.imageUrl),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                // TODO: Taşmalar engellenecek
                Text(
                  '${user.name}  ${user.surname}',
                  style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w500),
                ),
                buildRow(
                  Icons.apartment_outlined,
                  user.university,
                  AppTextStyles.body2,
                ),
                buildRow(
                  Icons.school_outlined,
                  user.department,
                  AppTextStyles.body3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  CircleAvatar buildCircleAvatar(String url) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(url),
    );
  }

  Row buildRow(IconData icon, String txt, TextStyle ts) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppColors.orange,
        ),
        const SizedBox(width: 5),
        Text(
          txt,
          style: ts,
        ),
      ],
    );
  }
}
