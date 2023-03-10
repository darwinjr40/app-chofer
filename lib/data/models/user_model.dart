// To parse this JSON data, do
//
//     final data = dataFromMap(jsonString);

import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Data {
  Data({
    required this.message,
    required this.user,
    required this.bus,
    required this.vehiculos,
  });

  String message;
  User user;
  dynamic bus;
  List<Vehiculo> vehiculos;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        message: json["message"],
        user: User.fromMap(json["user"]),
        bus: json["Bus"],
        vehiculos: List<Vehiculo>.from(
            json["vehiculos"].map((x) => Vehiculo.fromMap(x))),
      );
}

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
    required this.busId,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
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
  dynamic busId;
  dynamic emailVerifiedAt;
  dynamic createdAt;
  dynamic updatedAt;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        admin: json["admin"],
        birthday: json["birthday"],
        ci: json["ci"],
        email: json["email"],
        gender: json["gender"],
        name: json["name"],
        phone: json["phone"],
        licenseCategoryId: json["license_category_id"],
        busId: json["bus_id"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

class Vehiculo {
  Vehiculo({
    required this.id,
    required this.contact,
    required this.photo,
    required this.plate,
    required this.seats,
    required this.busId,
    required this.carModelId,
    this.createdAt,
    this.updatedAt,
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
  Map<String, Polyline>? routes;

  factory Vehiculo.fromJson(String str) => Vehiculo.fromMap(json.decode(str));

  factory Vehiculo.fromMap(Map<String, dynamic> json) => Vehiculo(
        id: json["id"],
        contact: json["contact"],
        photo: json["photo"],
        plate: json["plate"],
        seats: json["seats"],
        busId: json["bus_id"],
        carModelId: json["car_model_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

class Ruta {
  Ruta({
    required this.ida,
    required this.vuelta,
  });

  List<LatLng> ida;
  List<LatLng> vuelta;

  factory Ruta.fromJson(String str) => Ruta.fromMap(json.decode(str));

  factory Ruta.fromMap(Map<String, dynamic> json) => Ruta(
        ida: List<LatLng>.from(json["ida"].map((x) => LatLng(
            double.parse((x)["latitude"]), double.parse((x)["longitude"])))),
        vuelta: List<LatLng>.from(json["vuelta"].map((x) => LatLng(
            double.parse((x)["latitude"]), double.parse((x)["longitude"])))),
      );
  // factory Path.fromMap(Map<String, dynamic> json) => Path(
  //     ida: List<LatLng>.from(json["ida"].map((x) => LatLng.fromMap(x))),
  //     vuelta: List<LatLng>.from(json["vuelta"].map((x) => LatLng.fromMap(x))),
  // );

  // Map<String, dynamic> toMap() => {
  //     "ida": List<dynamic>.from(ida.map((x) => x.toMap())),
  //     "vuelta": List<dynamic>.from(vuelta.map((x) => x.toMap())),
  // };
}
