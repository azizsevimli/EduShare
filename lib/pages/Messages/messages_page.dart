import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/constants.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/card_image_area.dart';
import '../../core/widgets/custom_circular_indicator.dart';
import '../../models/material_model.dart';
import '../../models/user_model.dart';
import '../../services/material_service.dart';
import '../../services/message_services.dart';
import '../../services/user_service.dart';

class MessagesPage extends StatefulWidget {
  final String currentUserId;
  const MessagesPage({super.key, required this.currentUserId});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final MaterialServices materialService = MaterialServices();
  final MessageService messageService = MessageService();
  final UserServices userService = UserServices();

  void goChatPage({
    required UserModel user,
    required String targetUserId,
    required String materialId,
  }) {
    context.push(
      '/messages/chat/$materialId/${widget.currentUserId}/$targetUserId',
      extra: user,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Mesajlarım',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: messageService.getChatsForUser(
              currentUserId: widget.currentUserId,
            ),
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
        
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: chats.length,
                  itemBuilder: (context, i) {
                    final chat = chats[i];
                    final targetUserId = chat['targetUserId'];
                    final lastMessage = chat['lastMessage'];
                    final materialId = chat['materialId'];
                        
                    return FutureBuilder(
                      future: Future.wait(
                        [
                          userService.getUserData(uid: targetUserId),
                          materialService.getMaterialById(id: materialId),
                        ],
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CustomCircularIndicator();
                        }
                        
                        if (snapshot.hasError || snapshot.data == null) {
                          return const Text('Veriler alınamadı.');
                        }
                        
                        final UserModel user = snapshot.data![0] as UserModel;
                        final MaterialModel material =
                            snapshot.data![1] as MaterialModel;
                        
                        return GestureDetector(
                          onTap: () {
                            goChatPage(
                              user: user,
                              targetUserId: targetUserId,
                              materialId: materialId,
                            );
                          },
                          child: Container(
                            width: size.width,
                            height: size.height * 0.08,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 5.0,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical: 5.0,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColors.tiffany,
                                  width: 0.5,
                                ),
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),
                            ),
                            child: buildListTileRow(
                              material: material,
                              user: user,
                              lastMessage: lastMessage,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Row buildListTileRow({
    required MaterialModel material,
    required UserModel user,
    required String lastMessage,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CardImageArea(urls: material.imageUrls),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                material.title,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.black,
                ),
              ),
              Text(
                '${user.name} ${user.surname}',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.tiffany,
                ),
              ),
              Text(
                lastMessage,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
