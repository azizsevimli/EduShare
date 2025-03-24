import 'package:edushare/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/user_model.dart';
import '../../models/product_model.dart';
import '../constants/constants.dart';
import './custom_button.dart';

class MaterialInfoArea extends StatefulWidget {
  final ProductModel product;

  const MaterialInfoArea({
    super.key,
    required this.product,
  });

  @override
  State<MaterialInfoArea> createState() => _MaterialInfoAreaState();
}

class _MaterialInfoAreaState extends State<MaterialInfoArea> {
  final UserServices us = UserServices();
  UserModel? ownerUser;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOwnerData();
  }

  Future<void> _loadOwnerData() async {
    try {
      final user = await us.getUserData(uid: widget.product.owner);
      setState(() {
        ownerUser = user;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Kullanıcı verisi alınamadı: $e");
    }
  }

  void sendMessage() {
    debugPrint('Mesaj gönder: ${widget.product.owner}');
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
          widget.product.description,
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
        widget.product.isSold
            ? _buildSoldContainer(size: size, context: context)
            : CustomElevatedButton(
                text: 'Mesaj Gönder',
                onPressed: sendMessage,
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
          widget.product.title,
          style: AppTextStyles.h2.copyWith(
            color: AppColors.wine,
          ),
        ),
        widget.product.price == '0'
            ? Text(
                'Ücretsiz',
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.orange,
                ),
              )
            : Row(
                children: [
                  Text(
                    widget.product.price,
                    style: AppTextStyles.h2.copyWith(
                      color: AppColors.orange,
                    ),
                  ),
                  const Icon(
                    Icons.currency_lira,
                    color: AppColors.orange,
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
        debugPrint('Kategoriye git: ${widget.product.department}');
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
                color: AppColors.orange,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(widget.product.department,
                  style: AppTextStyles.body3.copyWith(color: AppColors.wine)),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _buildOwnerRow() {
    return GestureDetector(
      onTap: () {
        context.push('/user-detail/${ownerUser!.uuid}');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isLoading
              ? const CircularProgressIndicator()
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

  Container _buildSoldContainer(
      {required Size size, required BuildContext context}) {
    return Container(
      width: size.width,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.vanilla,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1,
          color: AppColors.darkVanilla,
        ),
      ),
      child: Center(
        child: Text(
          'Satıldı',
          style: AppTextStyles.body2.copyWith(color: AppColors.orange),
        ),
      ),
    );
  }
}
