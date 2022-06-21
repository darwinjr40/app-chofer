import 'package:flutter/material.dart';
import 'package:micros_app/data/services/services.dart';
import 'package:micros_app/presentation/screens/screens.dart';
import 'package:provider/provider.dart';

class SelectBusScreen extends StatelessWidget {
  const SelectBusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final busServices = Provider.of<BusService>(context);
    // if (busServices.isLoading) {
    //   print("Loading");
    //   // return const LoadingScreen();
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Lista de Buses")),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        // reverse: true,
        // separatorBuilder: (_, __) => const Divider(height: 30),
        itemCount: busServices.listaBuses.length,
        itemBuilder: (context, index) => ListTile(
          title: Text('Linea ${busServices.listaBuses[index].id.toString()}',
              style: const TextStyle(color: Colors.black)),
          leading: const Icon(
            Icons.directions_bus_outlined,
            color: Colors.black,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_sharp,
            color: Colors.black,
          ),
          onTap: () => {
            busServices.selectedBus = busServices.listaBuses[index],
            print(busServices.selectedBus.id.toString()),
            Navigator.pushNamed(context, 'selectVehicle', arguments: busServices.selectedBus),
          },
        ),
      ),
      // separatorBuilder: (_, __) => const SizedBox(height: 5),
    );
  }
}
