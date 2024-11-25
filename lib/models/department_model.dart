class DepartmentModel {
  final List<Bachelor> bachelor;
  final List<Associate> associate;

  DepartmentModel({required this.bachelor, required this.associate});

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    final List jsonBachelor = json['Bachelor'];
    final List jsonAssociate = json['Associate'];
    return DepartmentModel(
      bachelor: jsonBachelor.map((e) => Bachelor.fromJson(e)).toList(),
      associate: jsonAssociate.map((e) => Associate.fromJson(e)).toList(),
    );
  }
}

class Bachelor {
  final String? name;

  Bachelor({required this.name});

  factory Bachelor.fromJson(Map<String, dynamic> json) {
    return Bachelor(name: json['name'] as String?);
  }

  @override
  String toString() {
    return name ?? 'Unnamed Bachelor';
  }
}

class Associate {
  final String? name;

  Associate({required this.name});

  factory Associate.fromJson(Map<String, dynamic> json) {
    return Associate(name: json['name'] as String?);
  }

  @override
  String toString() {
    return name ?? 'Unnamed Associate';
  }
}
