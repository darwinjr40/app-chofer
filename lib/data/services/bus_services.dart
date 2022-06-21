import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:micros_app/data/models/models.dart';

class BusService extends ChangeNotifier {
  final String _baseUrl = 'https://supportficct.ga/sig_backend/api/';
  final List<Bus> listaBuses = [];
  late Bus selectedBus;
  bool isLoading = true;
  bool isSaving = false;
  //----------------------------------------------------------------------------
  BusService() {
    loadBuses();
  }
  //----------------------------------------------------------------------------
  Future<List<Bus>> loadBuses() async {
    isLoading = true;
    notifyListeners();
    final url = (_baseUrl + 'bus/index');
    final resp = await http.get(Uri.parse(url));
    final jsonResponse = json.decode(resp.body);
    for (var item in jsonResponse) {
      Bus bus = Bus.fromMap(item);
      print('loadBuses');
      print(bus);
      listaBuses.add(bus);
    }
    isLoading = false;
    notifyListeners();
    print(listaBuses);
    print('finish loadBuses');
    return listaBuses;
  }
}
