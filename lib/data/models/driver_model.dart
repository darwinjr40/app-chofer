
import 'dart:convert';

// class Travel {
//     Travel({
//         required this.data,
//     });

//     List<Drivers> data;

//     factory Travel.fromJson(String str) => Travel.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Travel.fromMap(Map<String, dynamic> json) => Travel(
//         data: List<Drivers>.from(json["data"].map((x) => Drivers.fromMap(x))),
//     );

//     Map<String, dynamic> toMap() => {
//         "data": List<dynamic>.from(data.map((x) => x.toMap())),
//     };
// }

class Driver {
  Driver({
    required this.id,
    required this.inDate,
    this.outDate,
    required this.taken,
    required this.status,
    required this.currentLat,
    required this.currentLong,
    required this.userId,
    required this.vehicleId,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  int id;
  String inDate;
  String? outDate;
  int taken;
  int status;
  double currentLat;
  double currentLong;
  int userId;
  int vehicleId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? token;

  Driver copyWith({
    int? id,
    String? inDate,
    String? outDate,
    int? taken,
    int? status,
    double? currentLat,
    double? currentLong,
    int? userId,
    int? vehicleId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Driver(
        id: id ?? this.id,
        inDate: inDate ?? this.inDate,
        outDate: outDate ?? this.outDate,
        taken: taken ?? this.taken,
        status: status ?? this.status,
        currentLat: currentLat ?? this.currentLat,
        currentLong: currentLong ?? this.currentLong,
        userId: userId ?? this.userId,
        vehicleId: vehicleId ?? this.vehicleId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Driver.fromJson(String str) => Driver.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Driver.fromMap(Map<String, dynamic> json) => Driver(
        id: json["id"],
        inDate: json["inDate"],
        outDate: json["outDate"],
        taken: json["taken"],
        status: json["status"],
        currentLat: double.parse(json["currentLat"]),
        currentLong: double.parse(json["currentLong"]),
        userId: json["user_id"],
        vehicleId: json["vehicle_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "inDate": inDate,
        "outDate": outDate == null ? null : createdAt!.toIso8601String(),
        "taken": taken,
        "status": status,
        "currentLat": currentLat,
        "currentLong": currentLong,
        "user_id": userId,
        "vehicle_id": vehicleId,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
