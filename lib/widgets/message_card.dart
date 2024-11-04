import 'package:flutter/material.dart';

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
      decoration: const BoxDecoration(
        //color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 1,
          ),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(
                'assets/images/panda_512x512.png',
              ),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Kullanıcı Adı'),
                Text('Son Mesaj'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
