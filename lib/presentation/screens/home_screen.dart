import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:micros_app/data/services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

// ! Home Screen aqui va a ir un simple texto que diga Bienvenido $user
// ! Y un Boton que diga Go Online y suba sus coordenadas en vivo

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final busService = Provider.of<BusService>(context, listen: false);
    final vehicleService = Provider.of<VehicleService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('User: ${authService.user.name}'),
        backgroundColor: const Color.fromARGB(255, 12, 17, 156),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {
              authService.loguot();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text('4589VKU'),
                Text('Placa: ${vehicleService.selectedVehicle.plate}'),
                const SizedBox(width: 50),
                Text('Linea: ${busService.selectedBus.id}'),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text('Longitud: '),
                SizedBox(width: 30),
                Text('00000000000000'),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text('Latitud: '),
                SizedBox(width: 30),
                Text('00000000000000'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
