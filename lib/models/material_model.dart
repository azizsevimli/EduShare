import 'package:cloud_firestore/cloud_firestore.dart';

class MaterialModel {
  final String id;
  final String owner;
  final String title;
  final String description;
  final String price;
  final String category;
  final String subcategory;
  final String subject;
  final List<String> imageUrls;
  final bool isSold;
  final DateTime createdAt;

  MaterialModel({
    required this.id,
    required this.owner,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.subcategory,
    required this.subject,
    required this.imageUrls,
    required this.isSold,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner': owner,
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'subcategory': subcategory,
      'subject': subject,
      'imageUrl': imageUrls,
      'isSold': isSold,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory MaterialModel.fromMap(Map<String, dynamic> map) {
    return MaterialModel(
      id: map['id'] ?? '',
      owner: map['owner'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0.0,
      category: map['category'] ?? '',
      subcategory: map['subcategory'] ?? '',
      subject: map['subject'] ?? '',
      imageUrls: List<String>.from(map['imageUrl'] ?? []),
      isSold: map['isSold'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}