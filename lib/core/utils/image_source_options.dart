import 'dart:io';
import 'package:flutter/material.dart';

void showImageSourceOptions({
  required BuildContext context,
  required Function() onImageFromGallery,
  required Function() onImageFromCamera,
  required Function() onRemoveImage,
  File? image,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text("Galeriden seç"),
          onTap: () => onImageFromGallery(),
        ),
        ListTile(
          leading: const Icon(Icons.camera),
          title: const Text("Kamera ile çek"),
          onTap: () => onImageFromCamera(),
        ),
        if (image != null) ...[
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text("Resmi sil"),
            onTap: () => onRemoveImage(),
          ),
        ]
      ],
    ),
  );
}