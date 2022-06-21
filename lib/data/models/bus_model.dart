// To parse this JSON data, do
//
//     final bus = busFromMap(jsonString);
import 'dart:convert';

class Bus {
  Bus({
    required this.id,
    required this.color,
    required this.name,
    required this.photo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String color;
  String name;
  dynamic photo;
  int status;
  dynamic createdAt;
  dynamic updatedAt;

  factory Bus.fromJson(String str) => Bus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Bus.fromMap(Map<String, dynamic> json) => Bus(
        id: json["id"],
        color: json["color"],
        name: json["name"],
        photo: json["photo"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "color": color,
        "name": name,
        "photo": photo,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  @override
  String toString() {
    return 'id:  $id, color:  $color, name:  $name, photo:  $photo, status:  $status, createdAt:  $createdAt, updatedAt:  $updatedAt ';
  }
}
