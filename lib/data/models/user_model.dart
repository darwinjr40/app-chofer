// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.admin,
    required this.birthday,
    required this.ci,
    required this.email,
    required this.gender,
    required this.name,
    required this.phone,
    required this.licenseCategoryId,
  });

  int id;
  int admin;
  dynamic birthday;
  dynamic ci;
  String email;
  int gender;
  String name;
  dynamic phone;
  int licenseCategoryId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        admin: json["admin"],
        birthday: json["birthday"],
        ci: json["ci"],
        email: json["email"],
        gender: json["gender"],
        name: json["name"],
        phone: json["phone"],
        licenseCategoryId: json["license_category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "admin": admin,
        "birthday": birthday,
        "ci": ci,
        "email": email,
        "gender": gender,
        "name": name,
        "phone": phone,
        "license_category_id": licenseCategoryId,
      };

  @override
  String toString() {
    return ' id: $id admin: $admin birthday: $birthday ci: $ci email: $email gender: $gender name: $name phone: $phone licenseCategoryId: $licenseCategoryId';
  }
}
