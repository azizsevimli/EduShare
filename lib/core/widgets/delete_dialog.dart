import 'package:flutter/material.dart';
import './custom_button.dart';
import './custom_circular_indicator.dart';
import '../constants/constants.dart';
import '../../services/material_service.dart';

class DeleteDialog extends StatefulWidget {
  final String title;
  final String id;
  final int imageCount;

  const DeleteDialog({
    super.key,
    required this.title,
    required this.id,
    required this.imageCount,
  });

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  final MaterialServices materialServices = MaterialServices();
  bool isDeleting = false;

  Future<void> _handleDelete() async {
    setState(() => isDeleting = true);
    try {
      await materialServices.deleteMaterial(
        id: widget.id,
        imageCount: widget.imageCount,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
      setState(() => isDeleting = false);
      debugPrint("Materyal başarıyla silindi!");
    } catch (e) {
      setState(() => isDeleting = false);
      debugPrint("Materyal silinirken hata oluştu: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      title: const Text("Onay Gerekiyor"),
      content: Text(
        "'${widget.title}' adlı öğeyi silmek istediğinize emin misiniz?",
      ),
      actions: [
        CustomTextButton(
          onPressed: () => Navigator.of(context).pop(),
          text: 'İptal',
        ),
        isDeleting
            ? const CustomCircularIndicator(
                width: 100,
                height: 40,
                size: 30,
                color: AppColors.white,
                bgColor: AppColors.red,
              )
            : CustomElevatedButton(
                onPressed: _handleDelete,
                text: 'Sil',
                icon: Icons.delete_outline,
                bgColor: AppColors.red,
                fgColor: AppColors.white,
                width: 100,
              ),
      ],
    );
  }
}
