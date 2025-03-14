class ProductModel {
  final String owner;
  final String title;
  final String description;
  final String price;
  final String department;
  final String subject;
  final List<String> imageUrl;

  ProductModel({
    required this.owner,
    required this.title,
    required this.description,
    required this.price,
    required this.department,
    required this.subject,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'owner': owner,
      'title': title,
      'description': description,
      'price': price,
      'department': department,
      'subject': subject,
      'imageUrl': imageUrl,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      owner: map['owner'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0.0,
      department: map['department'] ?? '',
      subject: map['subject'] ?? '',
      imageUrl: List<String>.from(map['imageUrl'] ?? []),
    );
  }
}