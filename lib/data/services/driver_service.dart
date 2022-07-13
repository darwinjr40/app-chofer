import 'package:http/http.dart' as http;

class DriversService {
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
    print(resp);
  }
}
