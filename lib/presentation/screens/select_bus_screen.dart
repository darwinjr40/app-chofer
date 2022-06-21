import 'package:flutter/material.dart';

class SelectBusScreem extends StatelessWidget {
  const SelectBusScreem({Key? key}) : super(key: key);
  final listaBuses = const [
    'linea1',
    'linea2',
    'linea3',
    'linea4',
    'linea5',
    'linea6',
    'linea7',
    'linea8'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Lista de Buses")),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.separated(
        // reverse: true,
        separatorBuilder: (_, __) => const Divider(height: 30),
        itemCount: listaBuses.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(listaBuses[index],
              style: const TextStyle(color: Colors.black)),
          leading: const Icon(
            Icons.directions_bus_outlined,
            color: Colors.black,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_sharp,
            color: Colors.black,
          ),
          onTap: () => {},
        ),
      ),
      // separatorBuilder: (_, __) => const SizedBox(height: 5),
    );
  }
}
