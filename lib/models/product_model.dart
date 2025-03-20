class ProductModel {
  final String id;
  final String owner;
  final String title;
  final String description;
  final String price;
  final String department;
  final String subject;
  final List<String> imageUrls;
  final bool isSold;

  ProductModel({
    required this.id,
    required this.owner,
    required this.title,
    required this.description,
    required this.price,
    required this.department,
    required this.subject,
    required this.imageUrls,
    required this.isSold,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner': owner,
      'title': title,
      'description': description,
      'price': price,
      'department': department,
      'subject': subject,
      'imageUrl': imageUrls,
      'isSold': isSold,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      owner: map['owner'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0.0,
      department: map['department'] ?? '',
      subject: map['subject'] ?? '',
      imageUrls: List<String>.from(map['imageUrl'] ?? []),
      isSold: map['isSold'] ?? false,
    );
  }
}