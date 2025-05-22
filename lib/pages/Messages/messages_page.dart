import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/constants.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_circular_indicator.dart';
import '../../models/user_model.dart';
import '../../services/message_services.dart';
import '../../services/user_service.dart';

class MessagesPage extends StatefulWidget {
  final String currentUserId;
  const MessagesPage({super.key, required this.currentUserId});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final MessageService _ms = MessageService();
  final UserServices us = UserServices();

  void goChatPage({required UserModel user, required String targetUserId}) {
    context.push('/messages/chat/${widget.currentUserId}/$targetUserId', extra : user,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Mesajlarım',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _ms.getChatsForUser(currentUserId: widget.currentUserId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CustomCircularIndicator(),
              );
            }

            final chats = snapshot.data ?? [];

            if (chats.isEmpty) {
              return const Center(
                child: Text('Hiç mesajınız yok.'),
              );
            }

            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, i) {
                final chat = chats[i];
                final targetUserId = chat['targetUserId'];
                final lastMessage = chat['lastMessage'];

                return FutureBuilder<UserModel?>(
                    future: us.getUserData(uid: targetUserId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CustomCircularIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Kullanıcı verisi alınamadı.'),
                        );
                      }

                      final UserModel user = snapshot.data!;

                      return Container(
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          border: Border.symmetric(
                            horizontal: BorderSide(width: 1.0),
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(user.imageUrl),
                          ),
                          title: Text('${user.name} ${user.surname}'),
                          subtitle: Text(lastMessage),
                          onTap: () => goChatPage(user: user, targetUserId: targetUserId),
                        ),
                      );
                    });
              },
            );
          },
        ),
      ),
    );
  }
}
