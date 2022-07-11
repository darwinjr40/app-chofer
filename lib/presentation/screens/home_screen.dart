import 'package:flutter/material.dart';
import 'package:micros_app/presentation/widgets/card_container.dart';
import 'package:provider/provider.dart';

import 'package:micros_app/data/services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

// ! Home Screen aqui va a ir un simple texto que diga Bienvenido $user
// ! Y un Boton que diga Go Online y suba sus coordenadas en vivo

  @override
  Widget build(BuildContext context) {
    final _textController = TextEditingController();

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
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                        title: const Text('TERMINAR VIAJE'),
                        content: SizedBox(
                          width: 230,
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                  'Describa por que desea terminar el viaje'),
                              TextField(
                                controller: _textController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(0.0))),
                                ),
                                onSubmitted: (value) {},
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('cancelar'),
                          ),
                          TextButton(
                            onPressed: //_textController.text.isNotEmpty
                                // ?
                                () {
                              authService.loguot();
                              Navigator.pushReplacementNamed(context, 'login');
                            },
                            // : null,
                            child: const Text('ENVIAR'),
                          ),
                        ],
                      ));
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
