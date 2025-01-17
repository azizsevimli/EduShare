import 'dart:convert';

// AssociateModel sınıfı
class BachelorModel {
  final String name;

  BachelorModel({required this.name});

  // JSON'dan AssociateModel'e dönüştürme metodu
  factory BachelorModel.fromJson(Map<String, dynamic> json) {
    return BachelorModel(
      name: json['name'] as String,
    );
  }

  // AssociateModel'den JSON'a dönüştürme metodu
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
