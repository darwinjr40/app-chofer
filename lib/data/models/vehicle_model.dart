// To parse this JSON data, do
//
//     final vehicle = vehicleFromMap(jsonString);

import 'dart:convert';

class Vehicle {
    Vehicle({
        required this.id,
        required this.contact,
        required this.photo,
        required this.plate,
        required this.seats,
        required this.busId,
        required this.carModelId,
        required this.createdAt,
        required this.updatedAt,
        required this.color,
        required this.name,
        required this.status,
        required this.inDate,
        required this.outDate,
        required this.taken,
        required this.userId,
        required this.vehicleId,
    });

    int id;
    String contact;
    dynamic photo;
    String plate;
    int seats;
    int busId;
    int carModelId;
    dynamic createdAt;
    dynamic updatedAt;
    String color;
    String name;
    int status;
    DateTime inDate;
    DateTime outDate;
    int taken;
    int userId;
    int vehicleId;

    factory Vehicle.fromJson(String str) => Vehicle.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Vehicle.fromMap(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        contact: json["contact"],
        photo: json["photo"],
        plate: json["plate"],
        seats: json["seats"],
        busId: json["bus_id"],
        carModelId: json["car_model_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        color: json["color"],
        name: json["name"],
        status: json["status"],
        inDate: DateTime.parse(json["inDate"]),
        outDate: DateTime.parse(json["outDate"]),
        taken: json["taken"],
        userId: json["user_id"],
        vehicleId: json["vehicle_id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "contact": contact,
        "photo": photo,
        "plate": plate,
        "seats": seats,
        "bus_id": busId,
        "car_model_id": carModelId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "color": color,
        "name": name,
        "status": status,
        "inDate": "${inDate.year.toString().padLeft(4, '0')}-${inDate.month.toString().padLeft(2, '0')}-${inDate.day.toString().padLeft(2, '0')}",
        "outDate": "${outDate.year.toString().padLeft(4, '0')}-${outDate.month.toString().padLeft(2, '0')}-${outDate.day.toString().padLeft(2, '0')}",
        "taken": taken,
        "user_id": userId,
        "vehicle_id": vehicleId,
    };


    @override
  String toString() {
    return ' id: $id, contact: $contact, photo: $photo, plate: $plate, seats: $seats, busId: $busId, carModelId: $carModelId, createdAt: $createdAt, updatedAt: $updatedAt, color: $color, name: $name, status: $status, inDate: $inDate, outDate: $outDate, taken: $taken, userId: $userId, vehicleId: $vehicleId, ';
  }
}
