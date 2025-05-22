import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './custom_button.dart';
import './custom_circular_indicator.dart';
import '../constants/constants.dart';
import '../../models/user_model.dart';
import '../../models/material_model.dart';
import '../../services/user_service.dart';

class MaterialInfoArea extends StatefulWidget {
  final MaterialModel material;

  const MaterialInfoArea({
    super.key,
    required this.material,
  });

  @override
  State<MaterialInfoArea> createState() => _MaterialInfoAreaState();
}

class _MaterialInfoAreaState extends State<MaterialInfoArea> {
  final UserServices us = UserServices();
  UserModel? ownerUser;
  late String? currentUid;
  late String? targetUid;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    currentUid = us.getUserId();
    _loadOwnerData();
  }

  Future<void> _loadOwnerData() async {
    try {
      final user = await us.getUserData(uid: widget.material.owner);
      setState(() {
        ownerUser = user;
        targetUid = ownerUser!.uid;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Kullanıcı verisi alınamadı: $e");
    }
  }

  void sendMessage({required UserModel user}) {
    context.push(
      '/messages/chat/${widget.material.id}/$currentUid/$targetUid',
      extra: user,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleRow(),
        const SizedBox(height: 10),
        Text(
          widget.material.description,
          style: AppTextStyles.body1,
        ),
        const SizedBox(height: 15),
        _buildCategory(),
        const Divider(
          color: AppColors.grey,
          thickness: 0.5,
          height: 30,
        ),
        _buildOwnerRow(),
        const Divider(
          color: AppColors.grey,
          thickness: 0.5,
          height: 30,
        ),
        widget.material.isSold
            ? _buildSoldContainer(size: size, context: context)
            : CustomElevatedButton(
                text: 'Mesaj Gönder',
                onPressed: () => sendMessage(user: ownerUser!),
                icon: Icons.message_outlined,
                width: size.width,
              ),
      ],
    );
  }

  Row _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.material.title,
          style: AppTextStyles.h2.copyWith(
            color: AppColors.wine,
          ),
        ),
        widget.material.price == '0'
            ? Text(
                'Ücretsiz',
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.tiffany,
                ),
              )
            : Row(
                children: [
                  Text(
                    widget.material.price,
                    style: AppTextStyles.h2.copyWith(
                      color: AppColors.tiffany,
                    ),
                  ),
                  const Icon(
                    Icons.currency_lira,
                    color: AppColors.tiffany,
                    size: 20,
                  ),
                ],
              ),
      ],
    );
  }

  GestureDetector _buildCategory() {
    return GestureDetector(
      onTap: () {
        debugPrint('Kategoriye git: ${widget.material.category}');
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: AppColors.tiffany,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                widget.material.category,
                style: AppTextStyles.body3.copyWith(
                  color: AppColors.wine,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _buildOwnerRow() {
    return GestureDetector(
      onTap: () {
        context.push('/user-detail/${ownerUser!.uid}');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isLoading
              ? const CustomCircularIndicator(
                  width: 40,
                  height: 40,
                  bgColor: AppColors.white,
                )
              : CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(ownerUser!.imageUrl),
                ),
          const SizedBox(width: 15),
          Text(
            ownerUser == null ? '' : '${ownerUser!.name} ${ownerUser!.surname}',
            style: AppTextStyles.body1,
          ),
        ],
      ),
    );
  }

  Container _buildSoldContainer({
    required Size size,
    required BuildContext context,
  }) {
    return Container(
      width: size.width,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1,
          color: AppColors.rose,
        ),
      ),
      child: Center(
        child: Text(
          'Satıldı',
          style: AppTextStyles.body1.copyWith(
            color: AppColors.rose,
          ),
        ),
      ),
    );
  }
}
