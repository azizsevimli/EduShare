class UserModel {
  String uid;
  String name;
  String surname;
  String mail;
  String phone;
  String university;
  String department;
  String degree;
  String grade;
  String imageUrl;
  List<String> favoriteMaterials;
  bool isAdmin;

  UserModel({
    required this.uid,
    required this.name,
    required this.surname,
    required this.mail,
    required this.phone,
    required this.university,
    required this.department,
    required this.degree,
    required this.grade,
    required this.imageUrl,
    this.favoriteMaterials = const [],
    this.isAdmin = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'surname': surname,
      'mail': mail,
      'phone': phone,
      'university': university,
      'department': department,
      'degree': degree,
      'grade': grade,
      'imageUrl': imageUrl,
      'favoriteMaterials': favoriteMaterials,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      mail: map['mail'] ?? '',
      phone: map['phone'] ?? '',
      university: map['university'] ?? '',
      department: map['department'] ?? '',
      degree: map['degree'] ?? '',
      grade: map['grade'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      favoriteMaterials: List<String>.from(map['favoriteMaterials'] ?? []),
      isAdmin: map['isAdmin'] ?? false,
    );
  }
}
