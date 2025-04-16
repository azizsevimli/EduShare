class CategoryModel {
  final String name;
  final List<String> subcategories;

  CategoryModel({
    required this.name,
    required this.subcategories,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'subcategories': subcategories,
    };
  }

  factory CategoryModel.fromMap({required Map<String, dynamic> map}) {
    return CategoryModel(
      name: map['name'] as String,
      subcategories: List<String>.from(map['subcategories'] ?? []),
    );
  }
}
