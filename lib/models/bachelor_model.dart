class BachelorModel {
  final String name;

  BachelorModel({required this.name});
  factory BachelorModel.fromJson(Map<String, dynamic> json) {
    return BachelorModel(
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
