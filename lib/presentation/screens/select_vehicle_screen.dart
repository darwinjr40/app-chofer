import 'package:flutter/material.dart';
import 'package:micros_app/data/services/services.dart';
import 'package:micros_app/presentation/screens/screens.dart';
import 'package:provider/provider.dart';

class SelectVehicleScreen extends StatelessWidget {
  const SelectVehicleScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehicleServices = Provider.of<VehicleService>(context);
    
    print('primer vehiculo');

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Lista de Vehiculos")),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      // body: Text('nisaadasdasdsd'),
      body: ListView.builder(
        // reverse: true,
        // separatorBuilder: (_, __) => const Divider(height: 30),
        itemCount: vehicleServices.listaVehicles.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
              'Vehiculo ${vehicleServices.listaVehicles[index].id}',
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
            print(vehicleServices.listaVehicles[index].id.toString()),
          },
        ),
      ),
      // separatorBuilder: (_, __) => const SizedBox(height: 5),
    );
  }
}
