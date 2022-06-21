import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:micros_app/data/models/models.dart';

class VehicleService extends ChangeNotifier {
  final String _baseUrl = 'https://supportficct.ga/sig_backend/api/';
  final List<Vehicle> listaVehicles = [];
  late Vehicle selectedVehicle;
  bool isLoading = true;
  bool isSaving = false;
  //----------------------------------------------------------------------------
  VehicleService() {
    // loadVehicle(i);
    print('vechicle');
  }
  //----------------------------------------------------------------------------
  Future<List<Vehicle>> loadVehicle(int i) async {
    isLoading = true;
    notifyListeners();
    final url = (_baseUrl + 'vehicles/vehiculos-user/$i');
    final resp = await http.get(Uri.parse(url));
    final jsonResponse = json.decode(resp.body);
    print(i);
    for (var item in jsonResponse) {
      Vehicle vechicle = Vehicle.fromMap(item);
      print('loadVehicle');
      print(vechicle);
      listaVehicles.add(vechicle);
    }
    isLoading = false;
    notifyListeners();
    print('fuera del for');
    print(listaVehicles);
    return listaVehicles;
  }
}
