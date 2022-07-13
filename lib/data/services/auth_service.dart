import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:micros_app/data/models/user_model.dart';

// ! por ahora va a estar referenciado a uno de mis proyectos que tengo arriba
// ! cuando este la api de login lista lo cambio

class AuthService extends ChangeNotifier {
  final String _baseUrl = "https://supportficct.ga/sig_backend/public/api";
  late User user;
  late List<Vehiculo> listaVehiculos;
  late Vehiculo vehiculo;
  final storage = const FlutterSecureStorage();
    
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
}
