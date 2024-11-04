import 'package:flutter/material.dart';
import 'package:edushare/widgets/message_card.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

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
              const Text('Mesajlarınız'),
              const SizedBox(height: 10),
              Column(
                children: [
                  MessageCardView(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  const SizedBox(height: 10),
                  MessageCardView(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  const SizedBox(height: 10),
                  MessageCardView(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
