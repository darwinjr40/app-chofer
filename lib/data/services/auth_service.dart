import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:micros_app/data/models/models.dart';

// ! por ahora va a estar referenciado a uno de mis proyectos que tengo arriba
// ! cuando este la api de login lista lo cambio

class AuthService extends ChangeNotifier {
  final String _baseUrl = "https://supportficct.ga/sig_backend/public/api";
  late User user;
  late List<Vehiculo> listaVehiculos;
  late Vehiculo vehiculo;
  final storage = const FlutterSecureStorage();
  late bool isLoading;


  

  Future<String?> login(String email, String password) async {
    final resp = await http.post(Uri.parse('$_baseUrl/auth/login'),
        body: ({
          'email': email,
          'password': password,
        }));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp.containsKey('user')) {
      Data data = Data.fromMap(decodedResp);
      user = data.user;
      listaVehiculos = data.vehiculos;
      await storage.write(key: 'userId', value: '${user.id}');
      await storage.write(key: 'name', value: user.name);
      return null;
    } else {
      return 'revise sus credenciales';
    }
  }

  Future loguot() async {
    await storage.delete(key: 'userId');
    return;
  }

  Future<String> isLoged() async {
    return await storage.read(key: 'userId') ?? '';
  }

  void loadRutas() async {
    isLoading = true;
    notifyListeners();
    final markerStart = Cap.customCapFromBitmap(
        BitmapDescriptor.defaultMarkerWithHue(100),
        refWidth: 14.0);
    final marketFin =
        Cap.customCapFromBitmap(BitmapDescriptor.defaultMarker, refWidth: 14.0);
    List<PatternItem> listaPatterns = [
      PatternItem.dash(100.0),
      PatternItem.gap(5.0),
      PatternItem.dash(20.0),
      PatternItem.gap(30.0),
    ];
    final url = '$_baseUrl/vehicles/ruta/${vehiculo.id}';
    final resp = await http.get(Uri.parse(url));
    final jsonResponse = json.decode(resp.body);
    Ruta data = Ruta.fromMap(jsonResponse);

    Polyline lineaRutaIda = Polyline(
        polylineId: const PolylineId('ida'),
        color: Colors.green.withOpacity(0.7),
        width: 6,
        startCap: markerStart,
        endCap: marketFin,
        points: data.ida,
        patterns: listaPatterns);
    Polyline lineaRutaVuelta = Polyline(
        polylineId: const PolylineId('vuelta'),
        color: Colors.red.withOpacity(0.7),
        width: 6,
        startCap: markerStart,
        endCap: marketFin,
        points: data.vuelta,
        patterns: listaPatterns);

    Map<String, Polyline> routes = {
      'ida': lineaRutaIda,
      'vuelta': lineaRutaVuelta
    };
    vehiculo.routes = routes;
    isLoading = false;
    notifyListeners();
  }
}
