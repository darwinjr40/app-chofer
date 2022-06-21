import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:micros_app/data/models/models.dart';

class VehicleService extends ChangeNotifier {
  final String _baseUrl = 'https://supportficct.ga/sig_backend/api/';
  List<Vehicle> listaVehicles = []; //30 vehiculos para la linea 1
  late Vehicle selectedVehicle;
  bool isLoading = true;
  bool isSaving = false;
  //----------------------------------------------------------------------------
  VehicleService() {
    print('VehicleService constructor');
  }
  //----------------------------------------------------------------------------
  Future<List<Vehicle>> loadVehicle(int i) async {
    print(
        'loadVehicle------------------------------------------------------------');
    listaVehicles = [];
    isLoading = true;
    notifyListeners();
    final url = (_baseUrl + 'vehicles/vehiculos-user/$i');
    final resp = await http.get(Uri.parse(url));
    final jsonResponse = json.decode(resp.body);
    for (var item in jsonResponse) {
      Vehicle vechicle = Vehicle.fromMap(item);
      listaVehicles.add(vechicle);
    }
    isLoading = false;
    notifyListeners();
    print('fuera del for $i');
    print(listaVehicles);
    print(
        'loadVehicle------------------------------------------------------------');
    return listaVehicles;
  }
}
