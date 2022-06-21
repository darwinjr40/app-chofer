import 'package:flutter/material.dart';
import 'package:micros_app/data/services/services.dart';
import 'package:micros_app/presentation/screens/screens.dart';
import 'package:provider/provider.dart';

class SelectVehicleScreen extends StatelessWidget {
  const SelectVehicleScreen({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehicleServices = Provider.of<VehicleService>(context);
    // print(i);
    // // print(vehicleServices.listaVehicles[0].id.toString());
    // print('primer vehculo');\
    vehicleServices.loadVehicle(1);
    if (vehicleServices.isLoading) {
      print("Loading");
      // return const LoadingScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Lista de Vehiculos")),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        // reverse: true,
        // separatorBuilder: (_, __) => const Divider(height: 30),
        itemCount: vehicleServices.listaVehicles.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
              'Linea ${vehicleServices.listaVehicles[index].id.toString()}',
              style: const TextStyle(color: Colors.black)),
          subtitle: Text('Placa ${vehicleServices.listaVehicles[index].plate}'),
          leading: const Icon(
            Icons.directions_bus_outlined,
            color: Colors.black,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_sharp,
            color: Colors.black,
          ),
          onTap: () => {
            // vehicleServices.selectedBus = vehicleServices.listaVehicles[index],
            print(vehicleServices.selectedVehicle.id.toString()),
          },
        ),
      ),
      // separatorBuilder: (_, __) => const SizedBox(height: 5),
    );
  }
}
