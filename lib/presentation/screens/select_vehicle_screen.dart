import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_app/data/blocs/blocs.dart';
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
    final mapbloc = BlocProvider.of<MapBloc>(context);
    // final vehicleBloc = BlocProvider.of<VehicleBloc>(context);
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
          // onTap: _load(context, service, index),
          onTap: () async {
            service.vehiculo = service.listaVehiculos[index];
            service.loadRutas();
            await Future.delayed(const Duration(seconds: 3));
            mapbloc.add(OnAddPolylinesEvent(service.vehiculo.routes!));
            await Future.delayed(const Duration(seconds: 3));
            debugPrint('----------------');
            debugPrint('${mapbloc.state.polylines.length}');
            Navigator.pushReplacementNamed(context, 'loading');
          },
        ),
      ),
      // separatorBuilder: (_, __) => const SizedBox(height: 5),
    );
  }

  Future _load(BuildContext context, AuthService service, int index) async {}
}
