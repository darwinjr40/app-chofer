import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:micros_app/data/models/user_model.dart';

// ! por ahora va a estar referenciado a uno de mis proyectos que tengo arriba
// ! cuando este la api de login lista lo cambio

class AuthService extends ChangeNotifier {
  //DanielU Patch
  // final String _baseUrl = "admin.andresmontano.website";
  final String _baseUrl = "https://supportficct.ga/sig_backend/public/api";
  late User user;
  final storage = const FlutterSecureStorage();
  // final Set<Bus> listBus = {};

  Future<String?> login(String email, String password) async {
    final resp = await http.post(Uri.parse('$_baseUrl/auth/login'),
        body: ({
          'email': email,
          'password': password,
        }));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp.containsKey('user')) {
      // await storage.write(key: 'userId', value: decodedResp['usr_id']);
      user = User.fromJson(decodedResp['user']);
      await storage.write(
          key: 'userId', value: decodedResp['user']['id'].toString());
      await storage.write(
          key: 'name', value: decodedResp['user']['name'].toString());
      return null;
    } else {
      // return decodedResp['message'];
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
