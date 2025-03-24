import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/constants.dart';

class ProductImagePicker extends StatefulWidget {
  final List<File?> selectedImages;
  final ValueChanged<List<File?>> onImagesChanged;

  const ProductImagePicker({
    super.key,
    required this.selectedImages,
    required this.onImagesChanged,
  });

  @override
  State<ProductImagePicker> createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
  late List<File?> _images;

  @override
  void initState() {
    super.initState();
    _images = List.from(widget.selectedImages);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: width * 0.25,
      decoration: BoxDecoration(
        color: AppColors.periwinkle.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(4, (index) {
          return _buildImageBox(context, width, _images[index], index);
        }),
      ),
    );
  }

  GestureDetector _buildImageBox(BuildContext context, double width, File? selectedImage, int index) {
    return GestureDetector(
      onTap: () => _showImageSourceOptions(context, selectedImage, index),
      child: SizedBox(
        width: width * 0.2,
        height: width * 0.2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          clipBehavior: Clip.antiAlias,
          child: selectedImage != null
              ? Image.file(selectedImage, width: 100, height: 100, fit: BoxFit.cover)
              : Container(
            width: 120,
            height: 120,
            color: AppColors.periwinkle.withValues(alpha: 0.4),
            child: Center(
              child: Icon(
                Icons.add_photo_alternate_outlined,
                size: width * 0.075,
                color: AppColors.periwinkle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showImageSourceOptions(BuildContext context, File? selectedImage, int index) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Galeriden seç"),
            onTap: () {
              Navigator.of(ctx).pop();
              _pickImage(ImageSource.gallery, index);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text("Kamera ile çek"),
            onTap: () {
              Navigator.of(ctx).pop();
              _pickImage(ImageSource.camera, index);
            },
          ),
          if (selectedImage != null)
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Resmi sil"),
              onTap: () {
                Navigator.of(ctx).pop();
                _removeImage(index);
              },
            ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source, int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _images[index] = File(pickedFile.path);
        widget.onImagesChanged(_images);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      List<File?> newImages = List.from(_images);

      for (int i = index; i < newImages.length - 1; i++) {
        newImages[i] = newImages[i + 1];
      }

      newImages[newImages.length - 1] = null;

      _images = newImages;
      widget.onImagesChanged(_images);
    });
  }
}
