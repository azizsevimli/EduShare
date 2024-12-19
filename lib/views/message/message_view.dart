import 'package:flutter/material.dart';
import 'package:edushare/config/theme.dart';
import 'package:edushare/widgets/message_card.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Mesajlarınız',
                style: AppTxtStyle.h2.copyWith(color: AppColor.darkGray),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: MessageCardView(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
