import 'package:flutter/material.dart';
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
    debugPrint('LISTA DE VEHICULOS: ${service.listaVehiculos.length}----------------');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Vehiculos"),
        backgroundColor: primaryColor,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'login');
              // showLoguotDialog(context, service);
            },
          ),
        ],
      ),
      body: (service.listaVehiculos.isEmpty)
            ? const Center(child: Text("NO HAY VEHICULOS DISPONIBLES"))
            : ListVehicles(service: service)  ,
      // separatorBuilder: (_, __) => const SizedBox(height: 5),
    );
  }
}

class ListVehicles extends StatelessWidget {
  const ListVehicles({
    Key? key,
    required this.service,
  }) : super(key: key);

  final AuthService service;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
          Navigator.pushReplacementNamed(context, 'loading');
        },
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 5),
            child: const Text("Loading")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


