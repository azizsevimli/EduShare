import 'package:flutter/material.dart';

import '../../models/message_model.dart';
import '../../services/message_services.dart';
import '../constants/constants.dart';
import './custom_circular_indicator.dart';

class ChatMessageList extends StatelessWidget {
  final MessageService messageService;
  final ScrollController scrollController;
  final String currentUserId;
  final String targetUserId;

  const ChatMessageList({
    super.key,
    required this.messageService,
    required this.scrollController,
    required this.currentUserId,
    required this.targetUserId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageModel>>(
      stream: messageService.getMessages(userId1: currentUserId, userId2: targetUserId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CustomCircularIndicator(),
          );
        }
        final messages = snapshot.data ?? [];
        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isMe = message.senderId == currentUserId;
            return Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: isMe ? AppColors.white : AppColors.tiffany,
                  border: Border.all(color: AppColors.tiffany),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: isMe ? AppColors.black : AppColors.white,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
