
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DriversService {
  static bool estado = false;
  

  static void updateLocation({
    required String userId,
    required String vehiculeId,
    required double latitude,
    required double longitud,
  }) async {
    final url = Uri.parse(
      'https://supportficct.ga/sig_backend/public/api/drivers/setLatLong/$userId/$vehiculeId',
    );
    final resp = await http.put(
      url,
      body: {
        'currentLat': latitude.toString(),
        'currentLong': longitud.toString(),
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
    final url = Uri.parse(
      'https://supportficct.ga/sig_backend/public/api/sessions/write',
    );
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
}
