import 'package:flutter/material.dart';
import 'package:micros_app/data/models/models.dart';

class RecorridoService extends ChangeNotifier {
  final List<Bus> listaBuses = [];
  late Bus selectedBus;
  bool isActive = false;
  bool isSaving = false;
  //----------------------------------------------------------------------------
  void setActive(bool x) {
    isActive = x;
    notifyListeners();
  }

}
