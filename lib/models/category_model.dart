class CategoryModel {
  final String name;
  final List<String> subcategories;
  final String? id;

  CategoryModel({
    required this.name,
    required this.subcategories,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'subcategories': subcategories,
      'id': id,
    };
  }

  factory CategoryModel.fromMap({required Map<String, dynamic> map}) {
    return CategoryModel(
      name: map['name'] as String,
      subcategories: List<String>.from(map['subcategories'] ?? []),
      id: map['id'] as String?,
    );
  }
}
