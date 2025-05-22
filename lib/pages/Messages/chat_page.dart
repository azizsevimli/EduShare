import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/chat_message_list.dart';
import '../../core/widgets/chat_material_card.dart';
import '../../models/user_model.dart';
import '../../services/material_service.dart';
import '../../services/message_services.dart';

class ChatPage extends StatefulWidget {
  final UserModel user;
  final String materialId;
  final String currentUserId;
  final String targetUserId;

  const ChatPage({
    super.key,
    required this.user,
    required this.materialId,
    required this.currentUserId,
    required this.targetUserId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final MessageService messageService = MessageService();
  final MaterialServices materialService = MaterialServices();
  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();

  void _sendMessage() async {
    final text = messageController.text.trim();
    messageController.clear();
    if (text.isEmpty) return;

    await messageService.sendMessage(
      senderId: widget.currentUserId,
      receiverId: widget.targetUserId,
      materialId: widget.materialId,
      text: text,
    );

    Future.delayed(
      const Duration(milliseconds: 50),
      () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 50),
          curve: Curves.easeOut,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatPageAppBar(context: context, user: widget.user),
      body: Column(
        children: [
          ChatMaterialCard(
            materialId: widget.materialId,
            materialService: materialService,
          ),
          Expanded(
            child: ChatMessageList(
              messageService: messageService,
              scrollController: scrollController,
              currentUserId: widget.currentUserId,
              targetUserId: widget.targetUserId,
            ),
          ),
          buildMessageInput(),
        ],
      ),
    );
  }

  Padding buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: "Mesaj yaz...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  color: AppColors.xanthous,
                  onPressed: _sendMessage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
