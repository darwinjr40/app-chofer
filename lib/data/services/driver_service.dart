
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:micros_app/data/models/driver_model.dart';
import 'package:micros_app/data/services/services.dart';

class DriversService {
  static bool estado = false;
  static String token = '';
  

  static void updateLocation({
    required String userId,
    required String vehiculeId,
    required double latitude,
    required double longitud, 
    required int status,
  }) async {

    final _url = Env.baseUrl + 'drivers/setLatLong/$userId/$vehiculeId';
      // 'https://supportficct.ga/sig_backend/public/api/drivers/setLatLong/$userId/$vehiculeId',

    final url = Uri.parse(_url);
    final resp = await http.put(
      url,
      body: {
        'currentLat': latitude.toString(),
        'currentLong': longitud.toString(),
        'status': status.toString(),
      },
    );
    debugPrint('$resp');
  }

  static void inService({
    required int userId,
    required int vehicleId,
    required int isLogin,
    required String message,
  }) async {
    const _url = Env.baseUrl + 'sessions/write';
      // 'https://supportficct.ga/sig_backend/public/api/sessions/write',
    final url = Uri.parse(_url);
    // final resp = 
    await http.post(
      url,
      body: {
        'isLogin': isLogin.toString(),
        'message': message,
        'user_id': '$userId',
        'vehicle_id': '$vehicleId',
      },
    );
    // final Map<String, dynamic> decodedResp = json.decode(resp.body);
    // debugPrint(decodedResp.toString());
  }

  static Future<void> update(int id, Map<String, String> data) async {
    try {
      final url = '${Env.baseUrl}drivers/update/$id';
      final resp = await http.put(
        Uri.parse(url),
        headers: {'Accept' : 'application/json'},
        body: data,
      );
      if (resp.statusCode != 200) {
        debugPrint('ERROR <DriversService>update: ${resp.body}');
      }            
    } catch(error) {
      debugPrint('ERROR TRY CATCH <DriversService>update: ${error.toString()}');
      return Future.error(error.toString());
    }    
  }


  static Future<Driver?> getbyId(int idUser, int idVehicle) async {
    Driver? driver;
    try {
      final url = '${Env.baseUrl}drivers/get/$idUser/$idVehicle';
      final resp = await http.get(
        Uri.parse(url),
        headers: {'Accept' : 'application/json'},
      );
      if (resp.statusCode == 200) {
        driver = Driver.fromJson(resp.body);
      } else {
        debugPrint('ERROR <DriversService>getbyId: ${resp.body}');
      }           
    } catch(error) {
      debugPrint('ERROR TRY CATCH <DriversService>getbyId: ${error.toString()}');
    }    
      return driver;
  }
}
