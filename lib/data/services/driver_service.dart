
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:micros_app/data/services/services.dart';

class DriversService {
  static bool estado = false;
  

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

  static Future<void> update(String id,Map<String, dynamic> data) async {
    try {
      // return _ref.doc(travelInfo.id).set(travelInfo.toJson());
      debugPrint(data.toString());
      final url = '${Env.baseUrl}drivers/update/$id';
      final resp = await http.put(
        Uri.parse(url),
        headers: {'Accept' : 'application/json'},
        body: data,
      );
      // final Map<String, dynamic> decodedResp = json.decode(resp.body);
      if (resp.statusCode != 200) {
        debugPrint('ERROR <DriversService>update: ${resp.body}');
      }            
    } catch(error) {
      debugPrint(error.toString());
      return Future.error(error.toString());
    }    
  }
}
