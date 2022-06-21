import 'dart:convert';

List<Bus> busFromJson(String str) =>
    List<Bus>.from(json.decode(str).map((x) => Bus.fromJson(x)));

String busToJson(List<Bus> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bus {
  Bus({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  Bus copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }) =>
      Bus(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        avatar: avatar ?? this.avatar,
      );

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}
