class UserModel {
  String uuid;
  String name;
  String surname;
  String mail;
  String phone;
  String university;
  String department;
  String degree;
  String grade;
  String imageUrl;

  UserModel({
    required this.uuid,
    required this.name,
    required this.surname,
    required this.mail,
    required this.phone,
    required this.university,
    required this.department,
    required this.degree,
    required this.grade,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'name': name,
      'surname': surname,
      'mail': mail,
      'phone': phone,
      'university': university,
      'department': department,
      'degree': degree,
      'grade': grade,
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uuid: map['uuid'] ?? '',
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      mail: map['mail'] ?? '',
      phone: map['phone'] ?? '',
      university: map['university'] ?? '',
      department: map['department'] ?? '',
      degree: map['degree'] ?? '',
      grade: map['grade'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
