import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_app/data/blocs/vehicle/vehicle_bloc.dart';
import 'package:micros_app/data/services/services.dart';
import 'package:micros_app/env.dart';
import 'package:provider/provider.dart';

class SelectVehicleScreen extends StatelessWidget {
  const SelectVehicleScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<AuthService>(context);
    final vehicleBloc = BlocProvider.of<VehicleBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Lista de Vehiculos")),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      // body: Text('nisaadasdasdsd'),
      body: ListView.builder(
        // reverse: true,
        // separatorBuilder: (_, __) => const Divider(height: 30),
        itemCount: service.listaVehiculos.length,
        itemBuilder: (context, index) => ListTile(
          title: Text('Vehiculo ${service.listaVehiculos[index].id}',
              style: const TextStyle(color: Colors.black)),
          subtitle: Text('Placa ${service.listaVehiculos[index].plate}'),
          leading: const Icon(
            Icons.directions_bus_outlined,
            color: Colors.black,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_sharp,
            color: Colors.black,
          ),
          onTap: () => {
            service.vehiculo = service.listaVehiculos[index],
            // vehicleBloc.add(OnSetVehicleEvent(nuevoVehiculo: service.listaVehiculos[index]) ),
            // if (vehicleBloc.state.vehicle != null) return
            Navigator.pushReplacementNamed(context, 'home'),
          },
        ),
      ),
      // separatorBuilder: (_, __) => const SizedBox(height: 5),
    );
  }
}
