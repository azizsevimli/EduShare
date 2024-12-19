class University {
  final String? name;

  University({required this.name});

  factory University.fromJson(Map<String, dynamic> json) {
    return University(name: json['name'] as String?);
  }

  static List<University> uniNames(List<dynamic> json) {
    return json.map((e) => University.fromJson(e)).toList();
  }

  @override
  String toString() {
    return name ?? 'Unnamed University';
  }
}
