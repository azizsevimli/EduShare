class AssociateModel {
  final String name;

  AssociateModel({required this.name});

  factory AssociateModel.fromJson(Map<String, dynamic> json) {
    return AssociateModel(
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
