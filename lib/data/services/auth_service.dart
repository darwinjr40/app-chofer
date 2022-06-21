import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// ! por ahora va a estar referenciado a uno de mis proyectos que tengo arriba
// ! cuando este la api de login lista lo cambio

class AuthService extends ChangeNotifier {
  //DanielU Patch
  final String _baseUrl = "admin.andresmontano.website";
  final storage = const FlutterSecureStorage();
  Future<String?> login(String email, String password) async {
    final url = Uri.https(
        _baseUrl, 'api/logIn', {'usr_id': email, 'usr_pass': password});
    final resp = await http.get(url);
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    return null;
    if (decodedResp.containsKey('usr_id')) {
      await storage.write(key: 'userId', value: decodedResp['usr_id']);
      return null;
    } else {
      return decodedResp['message'];
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
