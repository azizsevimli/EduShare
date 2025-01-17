class UniversityModel {
  final String name;

  UniversityModel({required this.name});

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}