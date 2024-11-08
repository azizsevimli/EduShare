import 'package:flutter/material.dart';
import 'package:edushare/config/theme/theme.dart';

class MessageCardView extends StatelessWidget {
  const MessageCardView({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: screenWidth,
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*----User-Image----*/
            const CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(
                'assets/images/panda_512x512.png',
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*----User-Name----*/
                Text(
                  'Kullanıcı Adı',
                  style: AppTxtStyle.h3.copyWith(fontWeight: FontWeight.w600),
                ),
                /*----Last-Message----*/
                Text(
                  'Son Mesaj',
                  style:
                      AppTxtStyle.caption.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
